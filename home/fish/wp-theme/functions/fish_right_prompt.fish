# Display git branch and dirty bit and current time on the right
function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end
function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end
function fish_right_prompt
  set -l last_status $status
  set -l green (set_color green)
  set -l red  (set_color red)
  set -l reset  (set_color reset)
  # Echo the last error code, if any
  if test $last_status -ne 0
    echo $red '('$last_status') '
  end
  # Show git branch and dirty state
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    if [ (_is_git_dirty) ]
      set git_status $red '*'
    end
    echo -n -s $git_status $green '[' $git_branch ']'
  end
  echo -n -s $reset ' [' (date +%H:%M:%S) '] '
end