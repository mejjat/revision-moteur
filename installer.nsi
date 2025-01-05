; Revision Moteur Installer Script

!include "MUI2.nsh"
!include "FileFunc.nsh"

; General
Name "Revision Moteur"
OutFile "RevisionMoteur_Setup.exe"
InstallDir "$PROGRAMFILES\Revision Moteur"
InstallDirRegKey HKCU "Software\Revision Moteur" ""

; Interface Settings
!define MUI_ABORTWARNING
!define MUI_ICON "icon.ico"
!define MUI_UNICON "icon.ico"

; Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; Languages
!insertmacro MUI_LANGUAGE "French"

; Installer
Section "Revision Moteur" SecMain
    SetOutPath "$INSTDIR"
    
    ; Copy all files from the dist directory
    File /r "dist\Revision Moteur\*.*"
    
    ; Create shortcuts
    CreateDirectory "$SMPROGRAMS\Revision Moteur"
    CreateShortCut "$SMPROGRAMS\Revision Moteur\Revision Moteur.lnk" "$INSTDIR\Revision Moteur.exe"
    CreateShortCut "$DESKTOP\Revision Moteur.lnk" "$INSTDIR\Revision Moteur.exe"
    
    ; Write uninstaller
    WriteUninstaller "$INSTDIR\Uninstall.exe"
    
    ; Write registry keys for uninstall
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revision Moteur" \
                     "DisplayName" "Revision Moteur"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revision Moteur" \
                     "UninstallString" "$\"$INSTDIR\Uninstall.exe$\""
SectionEnd

; Uninstaller
Section "Uninstall"
    ; Remove files and directories
    RMDir /r "$INSTDIR\*.*"
    RMDir "$INSTDIR"
    
    ; Remove shortcuts
    Delete "$SMPROGRAMS\Revision Moteur\Revision Moteur.lnk"
    RMDir "$SMPROGRAMS\Revision Moteur"
    Delete "$DESKTOP\Revision Moteur.lnk"
    
    ; Remove registry keys
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revision Moteur"
    DeleteRegKey HKCU "Software\Revision Moteur"
SectionEnd
