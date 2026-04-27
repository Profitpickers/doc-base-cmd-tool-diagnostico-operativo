# 📖 Manuale Utente — SecurData Pro Suite

> **Versione 1.0 · Aprile 2026 · SecurData.pro**  
> Sviluppato da [ProfitPickers](https://profitpickers.github.io/securdata.pro/)

---

## 🛠 1. Preparazione Iniziale

Prima di eseguire qualsiasi script, segui questi passaggi:

1. **Estrai lo ZIP** — Non eseguire gli script direttamente dall'archivio compresso. Estrai tutti i file in una cartella locale (es. `C:\SecurData\`).
2. **Permessi di esecuzione:**
   - Lo script `SecurData_Scanner_FREE.bat` può essere avviato con doppio clic (funziona anche senza Admin, ma i dati potrebbero essere parziali).
   - Lo script `SecurData_Toolkit_PRO.bat` **richiede obbligatoriamente** il clic destro → *"Esegui come amministratore"*.
3. **Antivirus:** Alcuni antivirus (es. Windows Defender) potrebbero segnalare gli script `.bat` come sospetti, perché interagiscono con i file di sistema. È un **falso positivo**. Puoi aprire il file `.bat` con il Blocco Note per esaminare ogni riga del codice.
4. **Windows Defender SmartScreen:** Se compare un avviso blu "PC protetto da Windows", clicca "Ulteriori informazioni" → "Esegui comunque".

---

## 🔍 2. Scanner Diagnostico FREE

### Avvio
- Doppio clic su `SecurData_Scanner_FREE.bat`
- Per risultati completi: clic destro → "Esegui come amministratore"

### Cosa viene analizzato

Lo scanner crea automaticamente una cartella `Report_Diagnostico_[data]_[ora]` nella stessa cartella dello script.

| File generato | Contenuto |
|:---|:---|
| `00_RIEPILOGO.txt` | Indice di tutti i file con descrizione |
| `01_Hardware.txt` | CPU (core, frequenza, cache), RAM (slot, velocità, produttore), Dischi (SMART, dimensione, modello), GPU (driver, VRAM), Scheda madre, BIOS, Batteria |
| `02_Sistema.txt` | Versione e build Windows, variabili d'ambiente, uptime, patch installate |
| `03_Software.txt` | App installate (nome, versione, data), App Microsoft Store, processi attivi, servizi di sistema, task pianificati, driver installati |
| `04_Rete.txt` | Configurazione IP completa, tabella ARP, connessioni attive e porte aperte, DNS cache, cartelle condivise, tabella routing, ping test |
| `05_Sicurezza.txt` | Firewall Windows (tutti i profili), criteri di gruppo applicati, account utenti locali, audit policy, certificati, sessioni attive |
| `06_File_Sistema_Nascosti.txt` | pagefile.sys / hiberfil.sys / swapfile.sys, Windows.old, Copie Shadow VSS, Flussi di Dati Alternativi (ADS), dimensione cartelle nascoste |

### 💡 Trucchi per interpretare il report

- **`01_Hardware.txt` → sezione DISCHI:** controlla la voce `Status`. Se vedi `OK`, il disco è sano. Qualsiasi altra voce (es. `Pred Fail`) indica un disco che sta per morire — fai subito un backup!
- **`03_Software.txt` → sezione APP INSTALLATE:** scorrilo per trovare software "bloatware" installato a tua insaputa (toolbars, browser alternativi, trial scaduti).
- **`02_Sistema.txt` → cerca "Hotfix":** le righe con `KB` numerati sono le patch di sicurezza. Confronta con i bollettini Microsoft per sapere se sei aggiornato.
- **`06_File_Sistema_Nascosti.txt`:** se `pagefile.sys` supera 8 GB e hai più di 32 GB di RAM, valuta di ridimensionarlo con il Toolkit PRO.

---

## ⚡ 3. Toolkit Operativo PRO

### Avvio (OBBLIGATORIO come Admin)
1. Clic destro su `SecurData_Toolkit_PRO.bat`
2. Seleziona **"Esegui come amministratore"**
3. Se compare la richiesta UAC, clicca "Sì"

> ⚠️ **Lo script NON si avvia senza Admin.** Questa è una protezione voluta: le operazioni modificano il sistema.

---

### A. Pulizia Profonda — Opzione [1]

Elimina in modo sicuro:

| Cartella/File | Cosa contiene | Spazio recuperabile tipico |
|:---|:---|:---|
| `%TEMP%` | File temporanei dell'utente corrente | 100 MB – 5 GB |
| `C:\Windows\Temp` | File temporanei di sistema | 50 MB – 3 GB |
| `C:\Windows\Prefetch` | Cache di avvio rapido obsoleta | 50–500 MB |
| `C:\Windows\Logs` + `Panther` | Log di sistema e aggiornamenti | 50–500 MB |
| `$Recycle.Bin` | Cestino di TUTTI gli utenti | Variabile |
| DNS Cache | Cache risoluzioni DNS | Nessuno spazio, ma risolve errori di navigazione |
| `C:\Windows.old` | Vecchia installazione Windows | **20–40 GB tipicamente** |

> ⚠️ **Attenzione su Windows.old:** una volta eliminata, non puoi più tornare alla versione precedente di Windows. Assicurati che il sistema funzioni correttamente prima di procedere.

---

### B. Backup PRO con Robocopy — Opzione [2]

Il backup usa **Robocopy** invece del copia-incolla standard perché:

- **Sincronizzazione incrementale:** copia solo i file nuovi o modificati dall'ultimo backup (risparmio di tempo drastico)
- **Resilienza:** se il disco di destinazione si disconnette, riprende da dove si era fermato
- **Multithread:** usa 16 flussi contemporanei (`/MT:16`), riducendo i tempi fino al 60%
- **Log automatico:** crea un file `.txt` con il dettaglio di ogni file copiato/saltato

#### Modalità MIR vs COPY

| Modalità | Comportamento | Usa quando... |
|:---|:---|:---|
| **COPY** (sicura) | Aggiunge/aggiorna file, non elimina mai nulla dalla destinazione | Vuoi un backup cumulativo |
| **MIR** (specchio) | La destinazione diventa la copia esatta della sorgente. Se elimini un file dall'originale, **viene eliminato anche dal backup al prossimo avvio** | Vuoi un backup 1:1 perfetto |

> ⚠️ **Drag & Drop:** quando lo script chiede il percorso sorgente o destinazione, puoi **trascinare la cartella direttamente nella finestra CMD** — il percorso si scrive automaticamente.

---

### C. Ripara Sistema SFC + DISM — Opzione [3]

Eseguiti in sequenza ottimale:

1. **SFC /scannow** — Confronta ogni file di sistema con la copia originale Microsoft e li ripara.
   - Trova il log in: `C:\Windows\Logs\CBS\CBS.log`
2. **DISM /ScanHealth** — Analizza l'immagine Windows per danni
3. **DISM /RestoreHealth** — Scarica e ripara l'immagine da Microsoft (richiede Internet)
4. **DISM /StartComponentCleanup** — Rimuove componenti obsoleti da WinSxS

> **Quando usarlo:** se il PC crasha spesso, se SFC trova errori che non riesce a riparare, dopo un aggiornamento Windows problematico.

---

### D. Reset Rete — Opzione [4]

| Operazione | Cosa fa | Quando serve |
|:---|:---|:---|
| Flush DNS | Svuota la cache delle risoluzioni DNS | Siti web non si aprono o mostrano vecchi IP |
| Reset IP Stack | Ripristina il TCP/IP allo stato factory | Connessione parziale, errori "reti non identificate" |
| Reset Winsock | Ripristina il catalogo Winsock di Windows | App non si connettono pur avendo Internet |
| Rinnova IP | Ottiene un nuovo IP dal router (DHCP) | IP in conflitto o connessione bloccata |

> ⚠️ **Riavvio necessario** dopo il reset completo per applicare tutte le modifiche.

---

### E. Secret Shield — Opzione [5]

Usa il comando `attrib` di Windows per modificare gli attributi di file e cartelle.

| Livello | Comando | Visibilità |
|:---|:---|:---|
| **Nascondi** | `attrib +h` | Scompare da Explorer, ma visibile con "Mostra file nascosti" |
| **Super-Nascondi** | `attrib +h +s +r` | Invisibile anche con "Mostra file nascosti" attivo. Solo chi conosce il percorso esatto può accedervi. |
| **Rendi Visibile** | `attrib -h -s -r` | Rimuove tutti gli attributi, file torna visibile normalmente |

> **Drag & Drop funziona anche qui:** trascina la cartella da nascondere direttamente nella finestra CMD.

---

### F. Gestione Spazio — Opzione [6]

Mostra una panoramica completa dello spazio occupato:
- Tabella disco per partizione (totale, libero, usato, percentuale)
- I 20 file più grandi nella tua cartella utente (> 1 GB)
- Dimensione dei file speciali di sistema (pagefile, hiberfil, swapfile)
- Dimensione delle cartelle Windows più pesanti

---

### G. Processi Sospetti — Opzione [7]

Analisi dei processi in esecuzione per identificare attività anomale:
- Lista dei processi con percorso eseguibile (i processi legittimi hanno percorsi sotto `C:\Windows\` o `C:\Program Files\`)
- Connessioni di rete attive con processo associato
- Chiavi di avvio automatico nel registro (Run keys)
- Possibilità di terminare un processo sospetto inserendo il PID

> **Suggerimento:** copia il percorso di un processo sospetto e cercalo su [VirusTotal.com](https://www.virustotal.com) per verificarne la legittimità.

---

## 💡 4. Tabella Scorciatoie CMD

| Scorciatoia | Effetto |
|:---|:---|
| **TAB** | Autocompleta il nome di un file o cartella mentre scrivi |
| **↑ Freccia Su** | Richiama l'ultimo comando digitato |
| **↑↑ Freccia Su × N** | Scorri la cronologia dei comandi |
| **Ctrl + C** | Interrompe immediatamente qualsiasi script in esecuzione |
| **Ctrl + A** | Seleziona tutto il testo nella finestra CMD |
| **Ctrl + F** | Apre la ricerca nel testo della finestra CMD |
| **F7** | Mostra la cronologia completa dei comandi in un popup |
| **cls** | Pulisce lo schermo |
| **Drag & Drop** | Trascina file/cartelle nella finestra CMD per incollare il percorso |
| **Clic destro** | Incolla il testo copiato negli appunti nel CMD |

---

## ❓ 5. Domande Frequenti (FAQ)

**D: Il mio antivirus blocca lo script. È sicuro?**  
R: Sì. I file `.bat` interagiscono con il sistema operativo, cosa che alcuni antivirus segnalano per eccesso di cautela. Puoi aprire il file con il Blocco Note e leggere ogni riga. Il codice è completamente trasparente e documentato.

**D: Il backup ha eliminato dei file dalla destinazione. Perché?**  
R: Hai scelto la modalità **MIR** (Mirror Speculare). Questa modalità mantiene la destinazione identica alla sorgente: se un file viene eliminato dalla sorgente, viene eliminato anche dal backup. Per backup non distruttivi, scegli la modalità **COPY**.

**D: Lo script si chiude subito senza fare nulla.**  
R: Non stai eseguendo come Amministratore. Clic destro → "Esegui come amministratore".

**D: DISM dice "Il componente store è danneggiabile". Come procedo?**  
R: Esegui prima SFC, poi rilancia DISM con l'opzione RestoreHealth. Se il problema persiste, collega il PC a Internet e rilancia: DISM scaricherà i file corretti direttamente da Microsoft.

**D: Posso modificare gli script?**  
R: Assolutamente sì. Gli script sono in chiaro. Clic destro → "Modifica" per aprirli nel Blocco Note e personalizzarli.

**D: Posso eseguire lo Scanner su un PC aziendale?**  
R: Lo scanner è di sola lettura e non modifica nulla. Tuttavia, in ambienti aziendali verifica sempre con il tuo reparto IT prima di eseguire script non approvati.

---

## ⚠️ 6. Disclaimer e Sicurezza

> Questo strumento è fornito "così com'è" senza garanzie. Gli script sono stati progettati per la manutenzione ordinaria di sistemi Windows 10/11. L'uso del Toolkit PRO (che modifica il sistema) è sotto la piena responsabilità dell'utente. Si raccomanda **sempre** di creare un punto di ripristino prima di eseguire operazioni di manutenzione. La perdita di dati causata da uso improprio non è responsabilità di SecurData.pro o ProfitPickers.

---

## 📞 7. Supporto

- **Sito Web:** [https://profitpickers.github.io/securdata.pro/](https://profitpickers.github.io/securdata.pro/)
- **Risorse Gratuite:** [risorse-gratuite.html](https://profitpickers.github.io/securdata.pro/risorse-gratuite.html)

---

*© 2026 SecurData PRO — ProfitPickers. Tutti i diritti riservati.*
