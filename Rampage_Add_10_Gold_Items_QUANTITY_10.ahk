; RDR2 Rampage - Attempts to add 10 each of 10 gold valuables, including bars, jewelry, a nugget, and a pocket watch.
; Requires AutoHotkey v2. See README.md for setup and quantity assumptions.
; Open Character Stats -> Items -> Add to Inventory -> empty Custom input.
; F8 start | F9 pause/resume between items | F10 stop after current item
; F6 Enter test | F7 animal-fat identifier test (finish quantity manually)

#Requires AutoHotkey v2.0
#SingleInstance Force
SetKeyDelay(18, 18)

global Running := false
global Paused := false
global StopRequested := false

; Adjust these if your menu is slower.
CharDelay := 4
AfterSubmitDelay := 450
ReopenDelay := 250

Items := [
    "PROVISION_BRACELET_GOLD",
    "PROVISION_BUCKLE_GOLD",
    "PROVISION_EARRING_GOLD",
    "PROVISION_GOLDBAR_LARGE",
    "PROVISION_GOLDBAR_SMALL",
    "PROVISION_GOLDRING",
    "PROVISION_GOLDTOOTH",
    "PROVISION_GOLD_NUGGET",
    "PROVISION_NECKLACE_GOLD",
    "PROVISION_POCKET_WATCH_GOLD"
]

TypeRampageText(text) {
    global CharDelay
    ; SendText generates actual text keystrokes rather than clipboard paste.
    ; Sending one character at a time is slower but much more reliable in
    ; Rockstar/Rampage native text-entry boxes.
    for ch in StrSplit(text) {
        SendText(ch)
        Sleep(CharDelay)
    }
}

PressGameEnter() {
    ; Lower-level Windows keyboard event for the main Enter key.
    ; VK_RETURN = 0x0D, scan code = 0x1C.
    ; First call = key down, second call with KEYEVENTF_KEYUP = key up.
    DllCall("keybd_event", "UChar", 0x0D, "UChar", 0x1C, "UInt", 0, "UPtr", 0)
    Sleep(100)
    DllCall("keybd_event", "UChar", 0x0D, "UChar", 0x1C, "UInt", 0x0002, "UPtr", 0)
    Sleep(150)
}

; ENTER TEST
; Open Rampage's Custom text box and press F6.
; It should act exactly like pressing the physical Enter key once.
F6::{
    ToolTip("Sending scan-code Enter...")
    PressGameEnter()
    Sleep(1000)
    ToolTip()
}

; TEST ONE ITEM FIRST
F7::{
    ToolTip("Typing one test item...")
    TypeRampageText("PROVISION_ANIMAL_FAT")
    Sleep(150)
    PressGameEnter()
    ToolTip("Test submitted: PROVISION_ANIMAL_FAT")
    Sleep(1800)
    ToolTip()
}

F8::{
    global Running, Paused, StopRequested, Items
    global AfterSubmitDelay, ReopenDelay

    if Running
        return

    Running := true
    Paused := false
    StopRequested := false

    for index, item in Items {
        if StopRequested
            break

        while Paused && !StopRequested
            Sleep(100)

        if StopRequested
            break

        ToolTip("Rampage provisions: " index "/" Items.Length "`n" item "`nF9 pause | F10 stop")

        ; The Custom dialog must already be open for the first item.
        TypeRampageText(item)
        Sleep(100)
        ; Submit the provision identifier.
        PressGameEnter()
        Sleep(5000)

        ; Quantity screen: keep the existing "1" and type a 0 after it -> "10".
        SendText("0")
        Sleep(300)
        PressGameEnter()
        Sleep(2000)

        ; Re-select Rampage's "Add to Inventory" option.
        PressGameEnter()
        Sleep(2000)

        ; Give Rampage time before typing the next item.
        Sleep(AfterSubmitDelay)

        if index < Items.Length {
            ; Wait before typing the next provision.
            Sleep(ReopenDelay)
        }
    }

    ToolTip(StopRequested ? "Stopped." : "Finished attempting all " Items.Length " entries.")
    Sleep(2500)
    ToolTip()
    Running := false
}

F9::{
    global Running, Paused
    if !Running
        return
    Paused := !Paused
    ToolTip(Paused ? "Paused - F9 to resume" : "Resumed")
    Sleep(700)
    ToolTip()
}

F10::{
    global StopRequested
    StopRequested := true
}
