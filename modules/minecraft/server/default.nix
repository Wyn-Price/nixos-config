{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.service.mrpack-server;

  # TODO: whitelist?
  serverOpts = { name, config, ... }: {
    options = {
      enable = mkEnableOption "Minecraft server service";

      mrpack = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = lib.mdDoc ''
          The location of the mrpack file to run the server on.
        '';
      };

      modInstallCommand = mkOption {
        type = types.str;
        default = "";
        description = lib.mdDoc ''
          The command to run to install the mods, if any.
        '';
      };

      java = mkOption {
        type = types.package;
        default = with pkgs; openjdk17;
        description = lib.mdDoc ''
          The java package to use. Defaults to java 17
        '';
      };

      entrypoint = mkOption {
        type = types.str;
        default = "./run.sh";
        description = lib.mdDoc ''
          The command to run to start the server. Defaults to ./start
        '';
      };

      serverProperties = mkOption {
        type = with types; attrsOf (oneOf [ bool int str ]);
        default = {};
        description = lib.mdDoc ''
          Server properties to override
        '';
      };

      additionalInstallCommand = mkOption {
        type = types.str;
        default = "echo No additional Install Commands";
        description = lib.mdDoc ''
          The forge installer package to use, if any.
        '';
      };
    };
  };

   stopScript = pkgs.writeShellScript "minecraft-server-stop" ''
      ${pkgs.coreutils}/bin/echo stop > $1

      # Wait for the PID of the minecraft server to disappear before
      # returning, so systemd doesn't attempt to SIGKILL it.
      while kill -0 "$2" 2> /dev/null; do
        ${pkgs.coreutils}/bin/sleep 1s
      done
    '';

    # We won't build with eula=false
    eulaFile = builtins.toFile "eula.txt" ''
      # eula.txt managed by NixOS Configuration
      eula=true
    '';
in
{
  options = {
    service.mrpack-server = {
      enable = mkEnableOption "Whether the services is enabled at all";

      baseDir = mkOption {
        type = types.str;
        default = "/var/lib/minecraft";
        description = lib.mdDoc ''
          The base directory for all minecraft servers
        '';
      };

      servers = mkOption {
        type = with types; attrsOf (submodule serverOpts);
        default = {};
        description = lib.mdDoc ''
          mr-pack controlled minecraft server
        '';
      };

      eula = mkOption {
        type = types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether you agree to
          [Mojangs EULA](https://account.mojang.com/documents/minecraft_eula). This option must be set to
          `true` to run Minecraft server.
        '';
      };
    };
  };

  # TODO: service that
  #  - Installs forge if needed
  #  - Runs mrpack-install on the mrpack
  #  - Also replaces the server.properties
  #  - Whitelist?

  config = mkIf cfg.enable {
    users.users.minecraft = {
      description     = "Minecraft server service user";
      home            = cfg.baseDir;
      createHome      = true;
      isSystemUser    = true;
      group           = "minecraft";
    };
    users.groups.minecraft = {};

    systemd = mkMerge (mapAttrsToList (name: server:
      let
        service-name = "minecraft-server-mrpack-${name}";
        directory = "${cfg.baseDir}/${name}";
        stdInFile = "/run/minecraft-servers/${service-name}.stdin";
        modInstallCommand = if server.mrpack != null
          then  "${pkgs.mrpack-install}/bin/mrpack-install ${server.mrpack} --server-dir ${directory} --server-file run.sh"
          else server.modInstallCommand;
      in
      mkIf server.enable {
        sockets.${service-name} = {
          bindsTo = [ "${service-name}.service" ];
          socketConfig = {
            ListenFIFO = stdInFile;
            SocketMode = "0660";
            SocketUser = "minecraft";
            SocketGroup = "minecraft";
            RemoveOnStop = true;
            FlushPending = true;
          };
        };

        services.${service-name} = {
          enable = true;

          description   = "Minecraft Server Service ${name}";
          wantedBy      = [ "multi-user.target" ];
          requires      = [ "${service-name}.socket" ];
          after         = [ "network.target" "${service-name}.socket" ];

          serviceConfig = {
            Environment = "PATH=${server.java}/bin";
            ExecStart = "${pkgs.bash}/bin/bash -c 'cd ${directory} && ${pkgs.bash}/bin/bash run.sh'";
            ExecStop = "${stopScript} ${stdInFile} $MAINPID";
            Restart = "always";
            User = "minecraft";
            WorkingDirectory = cfg.baseDir;

            StandardInput = "socket";
            StandardOutput = "journal";
            StandardError = "journal";

            # Hardening
            CapabilityBoundingSet = [ "" ];
            DeviceAllow = [ "" ];
            LockPersonality = true;
            PrivateDevices = true;
            PrivateTmp = true;
            PrivateUsers = true;
            ProtectClock = true;
            ProtectControlGroups = true;
            ProtectHome = true;
            ProtectHostname = true;
            ProtectKernelLogs = true;
            ProtectKernelModules = true;
            ProtectKernelTunables = true;
            ProtectProc = "invisible";
            RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ];
            RestrictNamespaces = true;
            RestrictRealtime = true;
            RestrictSUIDSGID = true;
            SystemCallArchitectures = "native";
            UMask = "0077";
          };

          preStart = ''
            ${pkgs.coreutils}/bin/mkdir -p ${directory}
            cd ${directory}

            # Declarative files
            ${pkgs.coreutils}/bin/rm -rf mods/ eula.txt

            ${server.additionalInstallCommand}
            ${modInstallCommand}

            ${pkgs.coreutils}/bin/ln -sf ${eulaFile} eula.txt
          '';
        };
      }
    ) cfg.servers);

      # systemd.services = concatMapAttrs (name: server: {
      #   "mincraft-server-mrpack-${name}" = mkIf server.enable {
      #     enable = true;
      #     # TODO HERE
      #   };
      # }) cfg.servers;
     assertions = [
      { assertion = cfg.eula;
        message = "You must agree to Mojangs EULA to run minecraft-server."
          + " Read https://account.mojang.com/documents/minecraft_eula and"
          + " set `eula` to `true` if you agree.";
      }
    ];

  };
}
