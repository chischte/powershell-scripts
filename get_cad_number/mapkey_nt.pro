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
