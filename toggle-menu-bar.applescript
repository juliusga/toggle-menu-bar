--  # Check to see if System Preferences is a
--  # running and if yes, then close it.
if running of application "System Settings" then
	try
		tell application "System Settings" to quit
	on error
		do shell script "killall 'System Preferences'"
	end try
	delay 0.1
end if

--  # Make sure System Preferences is not running before
--  # opening it again. Otherwise there can be an issue
--  # when trying to reopen it while it's actually closing.
repeat while running of application "System Settings" is true
	delay 0.1
end repeat

--  # Open to Dock & Menu Bar
do shell script "open -j x-apple.systempreferences:com.apple.ControlCenter-Settings.extension"

set ALWAYS to "Always"
set ON_DESKTOP_ONLY to "On Desktop Only"
set IN_FULL_SCREEN_ONLY to "In Full Screen Only"
set NEVER to "Never"
tell application "System Events"
	tell application process "System Settings"
		repeat until exists (pop up button 1 of group 9 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window "Control Center")
			delay 0.2
		end repeat
		tell pop up button 1 of group 9 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window "Control Center"
			set currentValue to value of attribute "AXValue"
			click
			if currentValue is IN_FULL_SCREEN_ONLY then
				click menu item ALWAYS of menu 1
			else
				click menu item IN_FULL_SCREEN_ONLY of menu 1
			end if
		end tell
	end tell
end tell

delay 0.5
tell application "System Settings" to quit