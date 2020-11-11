! --------------------------------------------------------------------------------------------------
mapkey nt \
@MAPKEY_LABEL\
Neues 0000 Teil;\
@MAPKEY_NAME\
Erstellt ein neues Teil mit einer 0000 Versuchszeichnungsnummer;\
\
~ Select `main_dlg_cur` `appl_casc`;~ Close `main_dlg_cur` `appl_casc`;\
~ Command `ProCmdModelNew` ;\
~ Update `new` `InputPanel1` `Name_`;\
~ Update `new` `InputPanel2` `Ueblicher`;\
~ Activate `new` `OK`;
! --------------------------------------------------------------------------------------------------

! WORKS:
mapkey --- @SYSTEM start D:\ExpressPCBsetup.exe;
! WORKS:
mapkey --- @SYSTEM "start D:\ExpressPCBsetup.exe";

! DOES NOT WORK:
mapkey +++ @SYSTEM start C:\"Program Files"\Microsoft Office\root\Office16\WINWORD.EXE;

! WORKS:
mapkey """ \ @SYSTEM\@echo off\n\nREM\n\nset \%windir\%\\system32\\\n\nstart \
mapkey(continued) calc.exe\n\nexit;

