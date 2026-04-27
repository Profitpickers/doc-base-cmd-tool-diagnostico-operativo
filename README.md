# 🛡️ SecurData PRO — CMD Diagnostics & Operative Toolkit

> **Suite di Strumenti Windows per Diagnostica Profonda e Manutenzione Avanzata**

[![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-0078D4?style=flat-square&logo=windows)](https://www.microsoft.com/windows)
[![Type](https://img.shields.io/badge/Tipo-CMD%20%2F%20Batch-4A90E2?style=flat-square&logo=gnu-bash)](#)
[![FREE](https://img.shields.io/badge/Scanner-FREE%20%E2%80%94%20Gratuito-22c55e?style=flat-square)](#)
[![PRO](https://img.shields.io/badge/Toolkit-PRO%20%E2%80%94%20Iscritti-6366f1?style=flat-square)](#)
[![License](https://img.shields.io/badge/License-Uso%20Personale-f59e0b?style=flat-square)](#)

SecurData PRO è una suite di script Batch/PowerShell ottimizzati per utenti avanzati e professionisti IT che necessitano di uno **screening profondo dell'hardware e del software** Windows e di strumenti operativi rapidi per la manutenzione del sistema.

🌐 **[Visita il sito ufficiale](https://profitpickers.github.io/securdata.pro/)** | 📋 **[Manuale Completo](docs/Manuale_Utente.md)**

---

## 🚀 Caratteristiche Principali

### 🔍 1. Diagnostic Scanner — `SecurData_Scanner_FREE.bat` *(Gratuito)*

Strumento di **sola lettura** — non modifica nulla sul sistema. Genera un report strutturato completo in meno di 3 minuti.

| Sezione | Contenuto |
|:---|:---|
| **Hardware** | CPU (core, frequenza, cache), RAM (slot, velocità, produttore), Dischi SMART, GPU (driver, VRAM), Scheda Madre, BIOS, Batteria |
| **Sistema** | Versione OS, build Windows, uptime, variabili d'ambiente, patch installate |
| **Software** | App installate (Win32 + Store), processi attivi, servizi, task pianificati, driver |
| **Rete** | Configurazione IP, tabella ARP, porte aperte, DNS cache, routing, ping test |
| **Sicurezza** | Firewall (tutti i profili), criteri di gruppo, account locali, audit policy, certificati |
| **Zone Nascoste** | pagefile.sys, hiberfil.sys, swapfile.sys, Windows.old, Copie Shadow VSS, ADS |

### 🛠️ 2. Operative Toolkit — `SecurData_Toolkit_PRO.bat` *(Iscritti PRO)*

Menu interattivo con 8 funzioni operative avanzate. **Richiede privilegi di Amministratore.**

| Funzione | Descrizione |
|:---|:---|
| **[1] Pulizia Profonda** | Temp, Prefetch, Log, Windows.old, Cestino (tutti gli utenti), DNS cache |
| **[2] Backup PRO** | Robocopy multithread `/MT:16` con modalità Mirror o Incrementale, log automatico |
| **[3] Ripara Sistema** | SFC + DISM sequenziale (ScanHealth → RestoreHealth → ComponentCleanup) |
| **[4] Reset Rete** | Flush DNS, reset IP stack, reset Winsock, rinnovo DHCP |
| **[5] Secret Shield** | Nasconde/mostra file con attributi `+h +s +r` (invisibile anche con "Mostra nascosti" attivo) |
| **[6] Gestione Spazio** | Analisi disco, top 20 file più grandi, dimensione cartelle sistema |
| **[7] Processi Sospetti** | Processi con percorso, connessioni attive, Run keys registro, kill PID |
| **[8] Snapshot Rapido** | Report rapido sistema in un unico file (OS + disco + processi + rete) |

---

## 📂 Struttura del Repository

```
├── 📂 bin/
│   ├── SecurData_Scanner_FREE.bat     # Diagnostica sola lettura (FREE)
│   └── SecurData_Toolkit_PRO.bat      # Toolkit operativo (Iscritti PRO, richiede Admin)
├── 📂 docs/
│   └── Manuale_Utente.md              # Guida completa con FAQ e trucchi
├── 📂 logs/                           # Cartella placeholder per report generati
├── index.html                         # Landing page principale
├── scanner-diagnostico-free.html      # Pagina dettaglio Scanner FREE
└── README.md
```

---

## ⚙️ Requisiti

- **OS:** Windows 10 (1903+) o Windows 11
- **Scanner FREE:** Nessun requisito speciale (Admin opzionale, consigliato)
- **Toolkit PRO:** Privilegi di Amministratore obbligatori
- **DISM RestoreHealth:** Connessione Internet per download componenti da Microsoft
- **Robocopy:** Incluso in Windows (nessuna installazione richiesta)

---

## 🚀 Come Iniziare

### Scanner FREE
1. Scarica o clona questa repository
2. Apri la cartella `bin/`
3. Doppio clic su `SecurData_Scanner_FREE.bat`
4. Per risultati completi: clic destro → *"Esegui come amministratore"*
5. Attendi il completamento (1–3 minuti)
6. La cartella `Report_Diagnostico_[data]` si aprirà automaticamente

### Toolkit PRO *(riservato agli iscritti)*
1. Clic destro su `SecurData_Toolkit_PRO.bat`
2. Seleziona **"Esegui come amministratore"**
3. Conferma il dialogo UAC
4. Scegli un'opzione dal menu (1–8)

> 📥 Accesso al Toolkit PRO: [iscriviti alla lista dedicata](https://profitpickers.github.io/securdata.pro/)

---

## 💡 Tips & Tricks

- **Drag & Drop:** Puoi trascinare qualsiasi cartella all'interno della finestra CMD quando lo script richiede un percorso — il percorso viene inserito automaticamente.
- **Backup Velocità:** Il Toolkit PRO usa `/MT:16` (16 thread Robocopy), riducendo i tempi di backup fino al 60% rispetto al normale copia-incolla.
- **Super-Hidden Mode:** La funzione Secret Shield usa `attrib +h +s +r`, rendendo i file invisibili anche quando l'opzione "Mostra file nascosti" è attiva in Explorer.
- **Compatibilità Win11:** Lo Scanner include fallback PowerShell con `Get-CimInstance` per i sistemi Windows 11 24H2+ dove `wmic` è stato deprecato.
- **Falsi Positivi Antivirus:** Se il tuo AV blocca gli script, aprili con il Blocco Note per verificare il codice. Tutto il codice è in chiaro e documentato.

---

## ⚠️ Disclaimer

Questi strumenti sono forniti "così com'è". Lo **Scanner FREE** è di sola lettura e non modifica nulla. Il **Toolkit PRO** esegue operazioni che modificano il sistema: si raccomanda sempre di creare un punto di ripristino prima dell'uso (opzione integrata nel Toolkit). L'uso improprio di comandi come `rd /s /q` o `/MIR` può causare perdita di dati. SecurData.pro e ProfitPickers non sono responsabili per danni derivanti dall'uso improprio degli strumenti.

---

## 🤝 Contatti & Supporto

Sviluppato da **ProfitPickers** per la community No-Code e IT italiana.

- 🌐 **Sito Web:** [securdata.pro](https://profitpickers.github.io/securdata.pro/)
- 📋 **Risorse Gratuite:** [risorse-gratuite.html](https://profitpickers.github.io/securdata.pro/risorse-gratuite.html)
- 📖 **Documentazione:** [Manuale_Utente.md](docs/Manuale_Utente.md)

---

⭐ *Ti è stato utile questo strumento? Lascia una stella sulla repository e condividilo con chi ne ha bisogno.*
