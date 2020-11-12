! TODO: Skript erstellen um git files an richtigen ort zu verschieben
! TODO: Permanent Mapkey erstellen für neuladen von mapkey nt für Entwicklungszwecke ODER
! Mapkey lädt sich jedes mal automatisch selbst
! --------------------------------------------------------------------------------------------------

! 1.Der user startet mapkey nt
! 2.mapkey nt aktualisiert mapkey nt_run_manager und ruft es auf
! 3.mapkey nt_run_manager startet das powershell script und macht pause
! 4.das powershell script erzeugt anhand der benutzereingaben ein neues mapkey
! 5. der user drückt in mapkey nt_run_manager auf fortfahren
! 6.Mapkey nt_run_manager lädt das neu generierte mapkey und ruft es auf

mapkey nt \
Select `main_dlg_cur` `appl_casc`;\
mapkey(continued) ~ Close `main_dlg_cur` `appl_casc`;~ Command `ProCmdRibbonOptionsDlg` ;\
mapkey(continued) ~ Select `ribbon_options_dialog` `PageSwitcherPageList` 1 `ConfigLayout`;\
mapkey(continued) ~ Select `ribbon_options_dialog` `ConfigLayout.ImportExportBtn`;\
mapkey(continued) ~ Close `ribbon_options_dialog` `ConfigLayout.ImportExportBtn`;\
mapkey(continued) ~ Activate `ribbon_options_dialog` `ConfigLayout.Open`;\
mapkey(continued) ~ Trail `UI Desktop` `UI Desktop` `DLG_PREVIEW_POST` `file_open`;\
mapkey(continued) ~ Update `file_open` `Inputname` \
mapkey(continued) `C:\\git\\powershell-scripts\\get_cad_number\\mapkey_nt.pro`;\
mapkey(continued) ~ Command `ProFileSelPushOpen_Standard@context_dlg_open_cmd` ;\
mapkey(continued) ~ Activate `ribbon_options_dialog` `OkPshBtn`;


! --------------------------------------------------------------------------------------------------
mapkey nt_run_manager \
@MAPKEY_LABEL\
Neues 0000 Teil;\
@MAPKEY_NAME\
Erstellt ein neues Teil mit einer 0000 Versuchszeichnungsnummer;\
%nt_start_powershell;\
@MANUAL_PAUSEEnter druecken um neues Mapkey zu laden;\
%nt_load_new_mapkey;\
@MANUAL_PAUSEEnter druecken um neues Teil zu generieren;\
%nt_fill_in_numbers;
! --------------------------------------------------------------------------------------------------
mapkey nt_start_powershell \
mapkey(continued) @SYSTEMC:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe \
mapkey(continued) -noexit -Command "& \
mapkey(continued) '"C:\\git\\powershell-scripts\\get_cad_\
mapkey(continued) number\\get_cad_number.ps1'";
! --------------------------------------------------------------------------------------------------
mapkey nt_load_new_mapkey ~ Select `main_dlg_cur` `appl_casc`;\
mapkey(continued) ~ Close `main_dlg_cur` `appl_casc`;~ Command `ProCmdRibbonOptionsDlg` ;\
mapkey(continued) ~ Select `ribbon_options_dialog` `PageSwitcherPageList` 1 `ConfigLayout`;\
mapkey(continued) ~ Select `ribbon_options_dialog` `ConfigLayout.ImportExportBtn`;\
mapkey(continued) ~ Close `ribbon_options_dialog` `ConfigLayout.ImportExportBtn`;\
mapkey(continued) ~ Activate `ribbon_options_dialog` `ConfigLayout.Open`;\
mapkey(continued) ~ Trail `UI Desktop` `UI Desktop` `DLG_PREVIEW_POST` `file_open`;\
mapkey(continued) ~ Update `file_open` `Inputname` \
mapkey(continued) `C:\\git\\powershell-scripts\\get_cad_number\\mapkey_nt_fill_in_numbers.pro`;\
@MANUAL_PAUSEEnter druecken um neues Mapkey zu laden;\
mapkey(continued) ~ Command `ProFileSelPushOpen_Standard@context_dlg_open_cmd` ;\
mapkey(continued) ~ Activate `ribbon_options_dialog` `OkPshBtn`;



