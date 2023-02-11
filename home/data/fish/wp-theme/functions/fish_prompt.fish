function fish_prompt
  set -l last_status $status
  set -l cyan (set_color cyan)
  set -l green (set_color -o green)
  set -l red  (set_color -o red)
  if test $last_status -ne 0
    set ret_status $red '$'
  else
    set ret_status $green '$'
  end
  # Display the current directory name
  echo -n -s $cyan '[' (whoami) @ (hostname|cut -d . -f 1) ' ' (prompt_pwd) ']' $ret_status  $normal
  # Terminate with a nice prompt char
  echo -n -s ' ' $normal
end