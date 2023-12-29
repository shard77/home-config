{ inputs, pkgs, ...}:
{
  programs.lf = {
    enable = true;

    commands = let
      trash = ''''${{
        set -f
	gio trash $fx
      }}'';
    in {
      trash = trash;
      delete = trash;

      open = ''''${{
        case $(file --mime-type -Lb $f) in
	    text/*) lf -remote "send $id \$$EDITOR \$fx;;
	    *) for f in $fx; do $OPENER "$f" > /dev/null 2> /dev/null & done;;
	esac
      }}'';

      fzf = ''''${{
        res="$(find . -maxdepth 1 | fzf --reverse --header='Jump to location')"
	if [ -n "$res" ]; then
	    if [ -d "$res" ]; then
	        cmd="cd"
	    else
	        cmd="select"
	    fi
	    res="$(printf '%s' "$res" | sed 's/\\/\\\\/g;s/"/\\"/g')"
	    lf -remote "send $id $cmd \"$res"\""
	fi
      }}'';
    }
  }
}
