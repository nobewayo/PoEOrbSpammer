#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2
#SingleInstance Force
CoordMode "Pixel", "Screen"
Esc::CloseApp()
+Esc::CloseApp()
g_myAlterationOrbs := "0"

End::
{
	AltsInputBox()
	
Loop{
	Sleep SmartSleep()
    if (PixelGetColor(291, 535) = 0xe7b477) ;Check to see if inventory searc has found affix
	{
		Send "{Shift up}"
		SoundPlay "success.wav"
	    break 
	}
	else if (g_myAlterationOrbs == 0) ;Check if g_myAlterationOrbs is at 0
	{
		SoundPlay "fail.wav"
		Send "{Shift up}"
		break
	}
    else ;Apply orb
	{
		;SoundPlay "debugclick.wav"
		Click
		global g_myAlterationOrbs
		g_myAlterationOrbs := --g_myAlterationOrbs
		;MsgBox "You have " g_myAlterationOrbs " tries left."
	}
	}
}



AltsInputBox()
{
    myAlterationOrbs := InputBox("How many tries?", "Crafting Helper", "w200 h75")
	if (myAlterationOrbs.Result = "Cancel"){
		SoundPlay "error.wav"
		MsgBox "You need to input number of tries!"
		AltsInputBox()
		}
	else{
		global g_myAlterationOrbs
		g_myAlterationOrbs := myAlterationOrbs.Value
		MsgBox "You entered " g_myAlterationOrbs "."
		Send "{Shift down}"
		}
}



SmartSleep() ;random number    : = high chance   ? = low chance
{
	randomSleep := (Random(1, 20) = 1)   ; 5% chance
		? Random(1000, 2000)
		: Random(500, 850)
	return randomSleep
}



CloseApp()
{
Send "{Shift up}"
ExitApp
}