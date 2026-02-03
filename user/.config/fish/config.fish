if status is-interactive
    # Commands to run in interactive sessions can go here
	function fish_greeting
		set --local full_name "$(getent passwd $USER | cut -d : -f5 | cut -d , -f1)"
		set --local raw_time "$(last -n 2 $USER --fulltimes | sed -n '2p' | awk '{print $7, $6, $9, $8}')"
		set --local time_last_login "$(date -d "$raw_time" +'%a %d %b %Y, %-I:%M %p %Z')"
		set --local time_now "$(date +'%a %d %b %Y, %-I:%M:%S %p %Z')"

		echo "Welcome back, $full_name!"
		echo "Last login at $time_last_login."
		echo "The time now is $time_now."
	end
end
