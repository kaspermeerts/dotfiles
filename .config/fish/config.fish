# Why are GNU programs so damn loud?
alias octave="octave -q"
alias gdb="gdb -q"
alias bc="bc -lq"
alias gcc="gcc -Wall -Wextra"
alias hd="hexdump -C"
alias ffmpeg="ffmpeg -hide_banner"

set -e fish_greeting
function fish_greeting -d "Greet the user"
	git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME diff-index --quiet HEAD --
	or echo "dotfiles git repository needs updating"
end

function humanize_duration
	set -l hours   (math -s0 "$argv           / 3600000")
	set -l minutes (math -s0 "$argv % 3600000 /   60000")
	set -l seconds (math -s0 "$argv %   60000 /    1000")
	set -l millis  (math -s0 "$argv %    1000          ")
	if test $hours -eq 0 -a $minutes -eq 0
		printf                           {$seconds}"s %03d" $millis
	else if test $hours -eq 0
		printf             {$minutes}"m "{$seconds}"s %03d" $millis
	else
		printf {$hours}"h "{$minutes}"m "{$seconds}"s %03d" $millis
	end
end

function fish_right_prompt
	if not test $CMD_DURATION -a $CMD_DURATION -ge 500
		return
	end

	set_color green; humanize_duration $CMD_DURATION; set_color normal;
end
