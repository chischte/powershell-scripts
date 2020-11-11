mapkey nt @MAPKEY_NAMEErstellt ein neues Teil mit einer 0000 \
mapkey(continued) Versuchszeichnungsnummer;@MAPKEY_LABELNeues 0000 Teil;\
mapkey(continued) ~ Select `main_dlg_cur` `appl_casc`;~ Close `main_dlg_cur` `appl_casc`;\
mapkey(continued) ~ Command `ProCmdModelNew` ;~ Input `new` `InputPanel1` `N`;\
mapkey(continued) ~ Input `new` `InputPanel1` `Na`;~ Input `new` `InputPanel1` `Nam`;\
mapkey(continued) ~ Input `new` `InputPanel1` `Name`;~ Input `new` `InputPanel1` `Name `;\
mapkey(continued) ~ Input `new` `InputPanel1` `Name E`;~ Input `new` `InputPanel1` `Name Ei`;\
mapkey(continued) ~ Input `new` `InputPanel1` `Name Ein`;\
mapkey(continued) ~ Input `new` `InputPanel1` `Name Eing`;\
mapkey(continued) ~ Input `new` `InputPanel1` `Name Einge`;\
mapkey(continued) ~ Input `new` `InputPanel1` `Name Eingeb`;\
mapkey(continued) ~ Input `new` `InputPanel1` `Name Eingebe`;\
mapkey(continued) ~ Input `new` `InputPanel1` `Name Eingeben`;\
mapkey(continued) ~ Update `new` `InputPanel1` `Name Eingeben`;\
mapkey(continued) ~ Update `new` `InputPanel2` `Üblicher Name`;~ Activate `new` `OK`;\
mapkey(continued) ~ Activate `0_std_error` `OK`;~ Update `new` `InputPanel2` `Ueblicher Name`;\
mapkey(continued) ~ Activate `new` `OK`;~ Activate `0_std_error` `OK`;\
mapkey(continued) ~ Input `new` `InputPanel1` `NameEingeben`;\
mapkey(continued) ~ Update `new` `InputPanel1` `NameEingeben`;\
mapkey(continued) ~ Update `new` `InputPanel2` `UeblicherName`;~ Activate `new` `OK`;
mapkey ggg ~ Select `main_dlg_cur` `appl_casc`;\
mapkey(continued) ~ Close `main_dlg_cur` `appl_casc`;\
mapkey(continued) ~ Activate `main_dlg_cur` `page_Tools_control_btn` 1;\
mapkey(continued) ~ Command `ProCmdMmParams` ;\
mapkey(continued) ~ Move `relation_dlg` `relation_dlg` 2 13.659486 5.681723;\
mapkey(continued) ~ Arm `relation_dlg` `ParamsPHLay.ParTable` 2 `rowBEZEICHNUNG_D` `value`;\
mapkey(continued) ~ Disarm `relation_dlg` `ParamsPHLay.ParTable` 2 `rowBEZEICHNUNG_D` `value`;\
mapkey(continued) ~ Select `relation_dlg` `ParamsPHLay.ParTable` 2 `rowBEZEICHNUNG_D` `value`;\
mapkey(continued) ~ RButtonArm `relation_dlg` `ParamsPHLay.ParTable` 2 `rowBEZEICHNUNG_D` \
mapkey(continued) `value`;\
mapkey(continued) ~ PopupOver `relation_dlg` `ParamsPHLay.ParamUtils` 1 `ParamsPHLay.ParTable`;\
mapkey(continued) ~ Open `relation_dlg` `ParamsPHLay.ParamUtils`;\
mapkey(continued) ~ Close `relation_dlg` `ParamsPHLay.ParamUtils`;\
mapkey(continued) ~ Arm `relation_dlg` `ParamsPHLay.ParTable` 2 `rowPTC_MATERIAL_NAME` `value`;\
mapkey(continued) ~ Disarm `relation_dlg` `ParamsPHLay.ParTable` 2 `rowPTC_MATERIAL_NAME` \
mapkey(continued) `value`;\
mapkey(continued) ~ Select `relation_dlg` `ParamsPHLay.ParTable` 2 `rowPTC_MATERIAL_NAME` \
mapkey(continued) `value`;~ Select `relation_dlg` `ParamsPHLay.ParTable_INPUT` 1 `0`;\
mapkey(continued) ~ PopupOver `relation_dlg` `ParamsPHLay.ParamUtils` 1 \
mapkey(continued) `ParamsPHLay.ParTable_INPUT`;~ Open `relation_dlg` `ParamsPHLay.ParamUtils`;\
mapkey(continued) ~ Close `relation_dlg` `ParamsPHLay.ParamUtils`;\
mapkey(continued) ~ Activate `relation_dlg` `PB_OK`;
mapkey ++++ @SYSTEMdir\n;
mapkey """ @SYSTEM\@echo off\n\nREM\n\nset \%windir\%\\system32\\\n\nstart \
mapkey(continued) calc.exe\n\nexit;
