# RDR2 Rampage AutoHotkey Scripts

Keyboard automation for Rampage Trainer in Red Dead Redemption 2 Story Mode. Requires Windows, AutoHotkey v2, and a working Rampage installation.

## Scripts

- **Rampage_Add_10_Gold_Items_QUANTITY_10.ahk** — Attempts to add 10 each of 10 gold valuables, including bars, jewelry, a nugget, and a pocket watch.
- **Rampage_Add_All_Provisions_KEYBD_EVENT_RESELECT.ahk** — Attempts to add each of 664 listed provision identifiers, confirming the default quantity of 1.
- **Rampage_Add_PERFECT_PRISTINE_QUANTITY_10.ahk** — Attempts to add 10 each of 138 PERFECT or PRISTINE identifiers, including carcasses, pelts, hides, and legendary variants.

## How to use

1. Install AutoHotkey v2 and double-click the script you want to run. Run only one of these scripts at a time because they share hotkeys.
2. Start RDR2 Story Mode and open Rampage. Navigate to **Character Stats → Items → Add to Inventory**.
3. Open the **Custom** item input with an empty field and the blinking cursor visible. Keep the game focused.
4. Optionally press **F7** to type and submit `PROVISION_ANIMAL_FAT`. Finish the quantity prompt manually, then reopen an empty Custom input. This test does not run the batch quantity sequence.
5. Press **F8** to start the full list. The script types each identifier, confirms the quantity, and reselects Add to Inventory.
6. Press **F9** to pause/resume or **F10** to stop. Both take effect between items; the current item sequence can continue for several seconds. Starting again with F8 restarts the list from the beginning.

**F6** sends one Enter keypress for testing. Use F6/F7 only while a batch is idle. To exit a script, use its AutoHotkey tray icon → Exit.

## Quantity and timing

The gold and perfect/pristine scripts append `0` to an existing `1` in the quantity prompt to make `10`. They require the cursor after the existing digit, with that digit not selected. The all-provisions script simply confirms the existing quantity, expected to be `1`. Verify this menu behavior before running a batch.

The scripts send keys to the active window and do not detect game focus or validate whether an item was accepted. Keep the game focused and avoid other input while running. Completion means all identifiers were attempted.

If the menu responds too slowly, increase `CharDelay`, `AfterSubmitDelay`, `ReopenDelay`, or the fixed `Sleep(...)` values around the quantity/menu transitions. The scripts use character-by-character text entry and Windows keyboard events for Enter.

Documentation was checked against the source; in-game behavior has not been tested as part of this upload.
