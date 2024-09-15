#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2
#SingleInstance Force
;@Ahk2Exe-AddResource *WAVE success.wav
;@Ahk2Exe-AddResource *WAVE fail.wav
;@Ahk2Exe-AddResource *WAVE debugclick.wav
;@Ahk2Exe-AddResource *WAVE error.wav
CoordMode "Pixel", "Screen"
Esc::CloseApp()
+Esc::CloseApp()
g_myAlterationOrbs := "0"

End::
{
	AltsInputBox()
	
Loop{
	Sleep SmartSleep()
    if (PixelGetColor(291, 535) = 0xe7b477) ;Check to see if inventory search has found affix
	{
		Send "{Shift up}"
		SoundPlayFromResource("success.wav")
	    break 
	}
	else if (g_myAlterationOrbs == 0) ;Check if g_myAlterationOrbs is at 0
	{
		SoundPlayFromResource("fail.wav")
		Send "{Shift up}"
		break
	}
    else ;Apply orb
	{
		;SoundPlayFromResource("debugclick.wav")
		Click
		global g_myAlterationOrbs
		g_myAlterationOrbs := --g_myAlterationOrbs
		;MsgBox "You have " g_myAlterationOrbs " tries left."
	}
	}
}



AltsInputBox()
{
    myAlterationOrbs := InputBox("How many tries?", "PoEOrbSpammer", "w200 h75")
	if (myAlterationOrbs.Result = "Cancel"){
		SoundPlayFromResource("error.wav")
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

SoundPlayFromResource(SoundResourceName) {
    if (!A_IsCompiled) {
        SoundPlay(SoundResourceName)
    } else {
        module := DllCall("GetModuleHandle", "Ptr", 0, "Ptr")
        DllCall("Winmm.dll\PlaySoundA", "AStr", SoundResourceName, "Ptr", module, "UInt", 0x40005)
    }
}

CloseApp()
{
Send "{Shift up}"
ExitApp
}
