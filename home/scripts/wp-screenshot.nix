{ pkgs }:
with pkgs; writers.writeBashBin "wp-screenshot" ''
sleep 0.2;

temp=$HOME/screenshots/.current.png
folder=$HOME/screenshots/$(date +%Y-%m)
location=$folder/$(date +%d-%H.%M.%S).png

rm $temp 2> /dev/null;
${scrot}/bin/scrot -fs -e 'xclip -selection clipboard -t image/png -i $f' $temp;
returnValue=$?;

if [ $returnValue -eq 0 ]; then
    mkdir -p $folder;
    mv $temp $location;
    ${libnotify}/bin/notify-send $location -i $location;
fi
''
