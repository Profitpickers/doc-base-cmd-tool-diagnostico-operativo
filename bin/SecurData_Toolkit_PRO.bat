@echo off
:: ============================================================
::  SECURDATA PRO — Operative Toolkit PRO v1.0
::  Autore  : ProfitPickers / SecurData.pro
::  Licenza : Uso riservato agli iscritti SecurData PRO
::  Sito    : https://profitpickers.github.io/securdata.pro/
:: ============================================================
:: ATTENZIONE: Questo script MODIFICA il sistema.
:: Esegui SEMPRE come Amministratore.
:: Crea un punto di ripristino prima di operazioni critiche.
:: ============================================================

setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1
title SecurData PRO — Operative Toolkit v1.0

:: ── Controllo OBBLIGATORIO privilegi Admin ────────────────────
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 04
    cls
    echo.
    echo  ╔══════════════════════════════════════════════════════╗
    echo  ║             ACCESSO NEGATO — ERRORE                  ║
    echo  ╠══════════════════════════════════════════════════════╣
    echo  ║                                                      ║
    echo  ║  Questo tool richiede privilegi di Amministratore.   ║
    echo  ║                                                      ║
    echo  ║  Soluzione:                                          ║
    echo  ║  1. Chiudi questa finestra                           ║
    echo  ║  2. Clic destro su SecurData_Toolkit_PRO.bat        ║
    echo  ║  3. Seleziona "Esegui come amministratore"           ║
    echo  ║                                                      ║
    echo  ╚══════════════════════════════════════════════════════╝
    echo.
    pause
    exit /b 1
)

:: ── Funzione: crea punto di ripristino (opzionale) ────────────
:ask_restore_point
cls
color 0B
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║     SECURDATA PRO — OPERATIVE TOOLKIT v1.0           ║
echo  ║     https://profitpickers.github.io/securdata.pro/   ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
echo  Raccomandazione: Prima di operazioni di sistema, crea
echo  un punto di ripristino per sicurezza.
echo.
echo  [S] Crea punto di ripristino ora (consigliato)
echo  [N] Continua senza punto di ripristino
echo.
set /p rp_choice="Scelta [S/N]: "
if /i "%rp_choice%"=="S" (
    echo  Creazione punto di ripristino in corso...
    powershell -NoProfile -Command "Try { Checkpoint-Computer -Description 'SecurData PRO Toolkit - Pre-Operazione' -RestorePointType MODIFY_SETTINGS; Write-Host '[OK] Punto di ripristino creato.' } Catch { Write-Host '[INFO] Creazione non disponibile (normale in alcune edizioni Windows).' }" 2>nul
    echo.
    pause
)

:: ═══════════════════════════════════════════════════════════
::  MENU PRINCIPALE
:: ═══════════════════════════════════════════════════════════
:menu
cls
color 0B
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║     SECURDATA PRO — OPERATIVE TOOLKIT v1.0           ║
echo  ║     Computer: %computername%  Utente: %username%
echo  ╠══════════════════════════════════════════════════════╣
echo  ║                                                      ║
echo  ║  [1]  PULIZIA PROFONDA      — Temp, Log, Dinosauri   ║
echo  ║  [2]  BACKUP PRO            — Robocopy Multithread   ║
echo  ║  [3]  RIPARA SISTEMA        — SFC + DISM             ║
echo  ║  [4]  RESET RETE            — DNS, IP, Winsock       ║
echo  ║  [5]  SECRET SHIELD         — Nascondi/Mostra        ║
echo  ║  [6]  GESTIONE SPAZIO       — Analisi disco          ║
echo  ║  [7]  PROCESSI SOSPETTI     — Scansione task         ║
echo  ║  [8]  CREA REPORT RAPIDO    — Snapshot sistema       ║
echo  ║  [0]  ESCI                                           ║
echo  ║                                                      ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
set /p sel="  Seleziona un'opzione (0-8): "

if "%sel%"=="1" goto clean
if "%sel%"=="2" goto backup
if "%sel%"=="3" goto repair
if "%sel%"=="4" goto netfix
if "%sel%"=="5" goto secret_shield
if "%sel%"=="6" goto disk_analysis
if "%sel%"=="7" goto process_scan
if "%sel%"=="8" goto quick_report
if "%sel%"=="0" goto exit_tool
goto menu

:: ═══════════════════════════════════════════════════════════
::  [1] PULIZIA PROFONDA
:: ═══════════════════════════════════════════════════════════
:clean
cls
color 0A
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [1] PULIZIA PROFONDA — Rimozione File Obsoleti      ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
echo  Operazioni che verranno eseguite:
echo   [A] File Temp utente e sistema
echo   [B] Prefetch (avvio rapido obsoleto)
echo   [C] Log di sistema (Windows\Logs)
echo   [D] Cartella Windows.old (se presente)
echo   [E] Svuotamento Cestino di tutti gli utenti
echo   [F] Pulizia DNS Cache
echo.
echo  [ATTENZIONE] Windows.old verra ELIMINATO definitivamente!
echo  Non potrai piu tornare alla versione precedente di Windows.
echo.
set /p clean_confirm="  Confermi la pulizia completa? [S/N]: "
if /i not "%clean_confirm%"=="S" goto menu

echo.
echo  [+] Pulizia File Temporanei utente...
del /q /f /s "%TEMP%\*" >nul 2>&1
echo      %TEMP% — OK

echo  [+] Pulizia File Temporanei sistema...
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
echo      C:\Windows\Temp — OK

echo  [+] Pulizia Prefetch...
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1
echo      C:\Windows\Prefetch — OK

echo  [+] Pulizia Log di sistema...
del /q /f /s "C:\Windows\Logs\*.log" >nul 2>&1
del /q /f /s "C:\Windows\Panther\*.log" >nul 2>&1
echo      C:\Windows\Logs + Panther — OK

echo  [+] Pulizia Cestino di tutti gli utenti...
rd /s /q "%systemdrive%\$Recycle.Bin" >nul 2>&1
echo      $Recycle.Bin — OK

echo  [+] Flush DNS Cache...
ipconfig /flushdns >nul 2>&1
echo      DNS Cache — Svuotata

if exist "C:\Windows.old" (
    echo  [+] Rimozione C:\Windows.old ^(potrebbe richiedere alcuni minuti^)...
    rd /s /q "C:\Windows.old" >nul 2>&1
    echo      C:\Windows.old — RIMOSSA
) else (
    echo  [i] C:\Windows.old non presente, skip.
)

echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [OK] PULIZIA COMPLETATA!                            ║
echo  ╚══════════════════════════════════════════════════════╝
pause
goto menu

:: ═══════════════════════════════════════════════════════════
::  [2] BACKUP PRO — ROBOCOPY MULTITHREAD
:: ═══════════════════════════════════════════════════════════
:backup
cls
color 0B
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [2] BACKUP PRO — Robocopy Multithread (/MT:16)      ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
echo  Opzioni disponibili:
echo   [1] Backup Documenti (%%USERPROFILE%%\Documents)
echo   [2] Backup Desktop
echo   [3] Backup Download
echo   [4] Backup Percorso personalizzato
echo.
set /p backup_type="  Scelta [1-4]: "

set "SRC="
if "%backup_type%"=="1" set "SRC=%USERPROFILE%\Documents"
if "%backup_type%"=="2" set "SRC=%USERPROFILE%\Desktop"
if "%backup_type%"=="3" set "SRC=%USERPROFILE%\Downloads"
if "%backup_type%"=="4" (
    echo.
    echo  Trascina la cartella sorgente nella finestra CMD
    echo  (oppure digita il percorso completo):
    set /p SRC="  Sorgente: "
)

if not defined SRC (
    echo  [ERRORE] Nessuna sorgente selezionata.
    pause
    goto menu
)

if not exist "!SRC!" (
    echo  [ERRORE] Percorso non trovato: !SRC!
    pause
    goto menu
)

echo.
echo  Destinazione backup:
echo  Trascina il disco/cartella di destinazione
echo  (es. D:\Backup oppure E:\):
set /p DEST="  Destinazione: "

if not exist "!DEST!" (
    echo  [AVVISO] La destinazione non esiste. Creazione in corso...
    mkdir "!DEST!" 2>nul
)

for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value 2^>nul') do set "DT=%%I"
set "BACKUP_DIR=!DEST!\SecurData_Backup_%DT:~0,4%%DT:~4,2%%DT:~6,2%"
set "LOG_FILE=!DEST!\backup_log_%DT:~0,4%%DT:~4,2%%DT:~6,2%_%DT:~8,2%%DT:~10,2%.txt"

echo.
echo  Modalita' di backup:
echo   [1] MIR  — Mirror speculare (elimina file extra nella dest.)
echo   [2] COPY — Solo copia aggiornamenti (sicuro, non elimina)
echo.
set /p mirror_mode="  Scelta [1/2]: "

set "ROBO_FLAGS=/MT:16 /R:3 /W:5 /NP /TEE"
if "%mirror_mode%"=="1" (
    set "ROBO_FLAGS=/MIR /MT:16 /R:3 /W:5 /NP /TEE"
    echo.
    echo  [ATTENZIONE] Modalita' MIR: i file eliminati dalla sorgente
    echo  verranno ELIMINATI anche nel backup!
    set /p mir_confirm="  Confermi? [S/N]: "
    if /i not "!mir_confirm!"=="S" goto menu
)

echo.
echo  [+] Avvio Backup...
echo      Sorgente    : !SRC!
echo      Destinazione: !BACKUP_DIR!
echo      Log         : !LOG_FILE!
echo      Thread      : 16 (multithread)
echo.

robocopy "!SRC!" "!BACKUP_DIR!" %ROBO_FLAGS% /LOG:"!LOG_FILE!"

echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [OK] BACKUP COMPLETATO!                             ║
echo  ║  Log salvato in: !LOG_FILE!
echo  ╚══════════════════════════════════════════════════════╝
pause
goto menu

:: ═══════════════════════════════════════════════════════════
::  [3] RIPARA SISTEMA — SFC + DISM
:: ═══════════════════════════════════════════════════════════
:repair
cls
color 0E
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [3] RIPARA SISTEMA — SFC + DISM                     ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
echo  Operazioni:
echo   1. SFC /scannow     — Ripara file di sistema corrotti
echo   2. DISM /RestoreHealth — Ripara immagine Windows
echo   (ordine ottimale: prima SFC, poi DISM se serve)
echo.
echo  Durata stimata: 10-30 minuti.
echo  Non interrompere il processo!
echo.
set /p repair_confirm="  Avvio riparazione? [S/N]: "
if /i not "%repair_confirm%"=="S" goto menu

echo.
echo  ─────────────────────────────────────────────────────
echo  [+] FASE 1: System File Checker (SFC)...
echo  ─────────────────────────────────────────────────────
sfc /scannow

echo.
echo  ─────────────────────────────────────────────────────
echo  [+] FASE 2: DISM — Analisi immagine Windows...
echo  ─────────────────────────────────────────────────────
dism /online /cleanup-image /scanhealth

echo.
echo  ─────────────────────────────────────────────────────
echo  [+] FASE 3: DISM — Ripristino immagine Windows...
echo      (Scarica componenti da Microsoft se necessario)
echo  ─────────────────────────────────────────────────────
dism /online /cleanup-image /restorehealth

echo.
echo  ─────────────────────────────────────────────────────
echo  [+] FASE 4: Pulizia componenti obsoleti...
echo  ─────────────────────────────────────────────────────
dism /online /cleanup-image /startcomponentcleanup

echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [OK] RIPARAZIONE COMPLETATA!                        ║
echo  ║  Riavvio consigliato per applicare le modifiche.     ║
echo  ╚══════════════════════════════════════════════════════╝
pause
goto menu

:: ═══════════════════════════════════════════════════════════
::  [4] RESET RETE — DNS, IP, WINSOCK
:: ═══════════════════════════════════════════════════════════
:netfix
cls
color 09
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [4] RESET RETE COMPLETO                             ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
echo  Operazioni:
echo   [1] Flush DNS cache
echo   [2] Reset stack IP (netsh int ip reset)
echo   [3] Reset Winsock (netsh winsock reset)
echo   [4] Rinnova indirizzo IP (ipconfig /renew)
echo   [5] Tutte le operazioni sopra
echo.
set /p net_choice="  Scelta [1-5]: "

echo.
if "%net_choice%"=="1" goto net_dns
if "%net_choice%"=="2" goto net_ip
if "%net_choice%"=="3" goto net_winsock
if "%net_choice%"=="4" goto net_renew
if "%net_choice%"=="5" goto net_all
goto menu

:net_dns
echo  [+] Flush DNS Cache...
ipconfig /flushdns
echo  [+] Registrazione DNS...
ipconfig /registerdns
goto net_done

:net_ip
echo  [+] Reset stack IP...
netsh int ip reset "C:\Windows\Temp\ip_reset_log.txt"
goto net_done

:net_winsock
echo  [+] Reset Winsock...
netsh winsock reset
goto net_done

:net_renew
echo  [+] Rilascio e rinnovo IP...
ipconfig /release
ipconfig /renew
goto net_done

:net_all
echo  [+] Flush DNS Cache...
ipconfig /flushdns
ipconfig /registerdns
echo  [+] Reset stack IP...
netsh int ip reset "C:\Windows\Temp\ip_reset_log.txt"
echo  [+] Reset Winsock...
netsh winsock reset
echo  [+] Rilascio IP...
ipconfig /release
echo  [+] Rinnovo IP...
ipconfig /renew
goto net_done

:net_done
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [OK] RETE RESETTATA!                                ║
echo  ║  RIAVVIO NECESSARIO per applicare tutte le modifiche ║
echo  ╚══════════════════════════════════════════════════════╝
set /p reboot_now="  Vuoi riavviare ora? [S/N]: "
if /i "%reboot_now%"=="S" shutdown /r /t 15 /c "SecurData PRO: Riavvio post-reset rete"
pause
goto menu

:: ═══════════════════════════════════════════════════════════
::  [5] SECRET SHIELD — NASCONDI/MOSTRA CARTELLE
:: ═══════════════════════════════════════════════════════════
:secret_shield
cls
color 0D
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [5] SECRET SHIELD — Attributi File/Cartelle         ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
echo  Livelli di occultamento:
echo   [1] Nascondi       — File non visibile in Explorer
echo   [2] Super-Nascondi — Invisibile anche con "Mostra nascosti"
echo   [3] Rendi Visibile — Rimuovi tutti gli attributi nascosti
echo   [4] Verifica stato — Mostra attributi correnti
echo.
set /p shield_op="  Scelta [1-4]: "
echo.
echo  Trascina qui il file o la cartella
echo  (oppure digita il percorso completo):
set /p shield_path="  Percorso: "

if not exist "!shield_path!" (
    echo  [ERRORE] Percorso non trovato: !shield_path!
    pause
    goto menu
)

if "%shield_op%"=="1" (
    attrib +h "!shield_path!" /s /d
    echo  [OK] Cartella nascosta con attributo Hidden.
    echo       Visibile attivando "Mostra file nascosti" in Explorer.
)
if "%shield_op%"=="2" (
    attrib +h +s +r "!shield_path!" /s /d
    echo  [OK] Cartella SUPER-NASCOSTA.
    echo       NON visibile anche con "Mostra file nascosti" attivo.
    echo       Per ripristinarla usa questa stessa opzione [3].
)
if "%shield_op%"=="3" (
    attrib -h -s -r "!shield_path!" /s /d
    echo  [OK] Attributi rimossi. File/Cartella ora visibile.
)
if "%shield_op%"=="4" (
    attrib "!shield_path!"
)

pause
goto menu

:: ═══════════════════════════════════════════════════════════
::  [6] GESTIONE SPAZIO — ANALISI DISCO
:: ═══════════════════════════════════════════════════════════
:disk_analysis
cls
color 0B
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [6] GESTIONE SPAZIO DISCO                           ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
echo  [+] Spazio disco per partizione:
powershell -NoProfile -Command "Get-PSDrive -PSProvider FileSystem | Format-Table Name,@{n='Totale(GB)';e={[math]::Round(($_.Used+$_.Free)/1GB,2)}},@{n='Libero(GB)';e={[math]::Round($_.Free/1GB,2)}},@{n='Usato(GB)';e={[math]::Round($_.Used/1GB,2)}},@{n='Usato%%';e={if(($_.Used+$_.Free) -gt 0){[math]::Round($_.Used/($_.Used+$_.Free)*100,1)}else{0}}} -AutoSize" 2>nul

echo.
echo  [+] File e cartelle piu grandi di 1 GB su C:\Users:
powershell -NoProfile -Command "Try { Get-ChildItem -Path $env:USERPROFILE -Recurse -ErrorAction SilentlyContinue | Where-Object {$_.Length -gt 1GB} | Sort-Object Length -Descending | Select-Object -First 20 FullName,@{n='GB';e={[math]::Round($_.Length/1GB,2)}} | Format-Table -AutoSize } Catch {}" 2>nul

echo.
echo  [+] File speciali sistema (pagefile, hiberfil, swapfile):
dir /a "C:\pagefile.sys" "C:\hiberfil.sys" "C:\swapfile.sys" 2>nul

echo.
echo  [+] Dimensione cartelle Windows Temp/Logs:
powershell -NoProfile -Command "Try { $paths=@('C:\Windows\Temp','C:\Windows\Prefetch','C:\Windows\Panther','C:\Windows\Logs','C:\Windows\SoftwareDistribution\Download'); foreach($p in $paths){if(Test-Path $p){$sz=(Get-ChildItem $p -Recurse -ErrorAction SilentlyContinue|Measure-Object -Property Length -Sum).Sum; Write-Host ('{0,-55} {1,8:N0} MB' -f $p,[math]::Round($sz/1MB,1))}}} Catch {}" 2>nul

pause
goto menu

:: ═══════════════════════════════════════════════════════════
::  [7] PROCESSI SOSPETTI
:: ═══════════════════════════════════════════════════════════
:process_scan
cls
color 0E
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [7] SCANSIONE PROCESSI SOSPETTI                     ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
echo  [+] Processi in esecuzione con percorso completo:
powershell -NoProfile -Command "Try { Get-Process | Where-Object {$_.Path} | Sort-Object CPU -Descending | Select-Object -First 30 ProcessName,Id,CPU,WorkingSet,@{n='Percorso';e={$_.Path}} | Format-Table -AutoSize } Catch {}" 2>nul

echo.
echo  [+] Connessioni di rete attive con processo associato:
powershell -NoProfile -Command "Try { $conns = Get-NetTCPConnection | Where-Object State -eq 'Established'; foreach($c in $conns){ $proc = Get-Process -Id $c.OwningProcess -ErrorAction SilentlyContinue; Write-Host ('{0,-20} {1,-20} {2,-6} {3}' -f $c.RemoteAddress,$c.RemotePort,$c.OwningProcess,($proc.Name + ' (' + $proc.Path + ')')) } } Catch { netstat -b 2>nul }" 2>nul

echo.
echo  [+] Avvio automatico (Run keys registro):
powershell -NoProfile -Command "Try { Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run' | Format-List; Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' | Format-List } Catch {}" 2>nul

echo.
echo  [i] Suggerimento: verifica processi insoliti su VirusTotal.com
echo      o confrontali con la tua lista software attendibile.
echo.
echo  [+] Termina processo sospetto? Inserisci il PID (o 0 per saltare):
set /p kill_pid="  PID da terminare (0 = no): "
if not "%kill_pid%"=="0" (
    if not "%kill_pid%"=="" (
        taskkill /f /pid %kill_pid%
        echo  [OK] Processo %kill_pid% terminato.
    )
)

pause
goto menu

:: ═══════════════════════════════════════════════════════════
::  [8] REPORT RAPIDO SISTEMA
:: ═══════════════════════════════════════════════════════════
:quick_report
cls
color 0A
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  [8] SNAPSHOT RAPIDO SISTEMA                         ║
echo  ╚══════════════════════════════════════════════════════╝
echo.

for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value 2^>nul') do set "DT=%%I"
set "QR_FILE=Snapshot_PRO_%DT:~0,4%%DT:~4,2%%DT:~6,2%_%DT:~8,2%%DT:~10,2%.txt"

echo  [+] Generazione snapshot in corso...
echo ============================================================ > "%QR_FILE%"
echo  SECURDATA PRO — Snapshot Rapido Sistema                   >> "%QR_FILE%"
echo  Data: %date%  Ora: %time%  PC: %computername%              >> "%QR_FILE%"
echo ============================================================ >> "%QR_FILE%"

echo. >> "%QR_FILE%"
echo ── SISTEMA ──────────────────────────────────────────── >> "%QR_FILE%"
ver >> "%QR_FILE%"
wmic os get Caption,Version,BuildNumber /format:list 2>nul >> "%QR_FILE%"
powershell -NoProfile -Command "Try { $u=(Get-Date)-(gcim Win32_OperatingSystem).LastBootUpTime; Write-Host ('Uptime: {0}d {1}h {2}m' -f [int]$u.Days,[int]$u.Hours,[int]$u.Minutes) } Catch {}" >> "%QR_FILE%"

echo. >> "%QR_FILE%"
echo ── SPAZIO DISCO ─────────────────────────────────────── >> "%QR_FILE%"
powershell -NoProfile -Command "Get-PSDrive -PSProvider FileSystem | Format-Table Name,@{n='TotGB';e={[math]::Round(($_.Used+$_.Free)/1GB,2)}},@{n='LibGB';e={[math]::Round($_.Free/1GB,2)}} -AutoSize" 2>nul >> "%QR_FILE%"

echo. >> "%QR_FILE%"
echo ── TOP 10 PROCESSI (CPU) ────────────────────────────── >> "%QR_FILE%"
powershell -NoProfile -Command "Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 ProcessName,Id,CPU,@{n='RAM_MB';e={[math]::Round($_.WorkingSet/1MB,1)}} | Format-Table -AutoSize" 2>nul >> "%QR_FILE%"

echo. >> "%QR_FILE%"
echo ── RETE ─────────────────────────────────────────────── >> "%QR_FILE%"
ipconfig /all >> "%QR_FILE%"

echo  [OK] Snapshot salvato: %QR_FILE%
echo.
pause
goto menu

:: ═══════════════════════════════════════════════════════════
::  USCITA
:: ═══════════════════════════════════════════════════════════
:exit_tool
cls
color 0B
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║  Grazie per aver usato SecurData PRO Toolkit!        ║
echo  ║                                                      ║
echo  ║  Sito: https://profitpickers.github.io/              ║
echo  ║        securdata.pro/                                ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
endlocal
exit /b 0
