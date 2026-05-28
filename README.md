# DracUtility79 - Windows Maintenance Tool V2

Now in version 2.0, **DracUtility79** is more than just a basic cleanup script—it is a comprehensive Windows maintenance utility. Developed from real-world IT experience to resolve common performance issues, it automates system repair, network troubleshooting, and performance tuning into a single command-line interface."

```
│███████╗███████╗ ██████╗  ██████╗██╗███████╗████████╗██╗   ██╗
│██╔════╝██╔════╝██╔═══██╗██╔════╝██║██╔════╝╚══██╔══╝╚██╗ ██╔╝
│█████╗  ███████╗██║   ██║██║     ██║█████╗     ██║    ╚████╔╝
│██╔══╝  ╚════██║██║   ██║██║     ██║██╔══╝     ██║     ╚██╔╝
│██║     ███████║╚██████╔╝╚██████╗██║███████╗   ██║      ██║
 ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝╚═╝╚══════╝   ╚═╝      ╚═╝
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   .#####.
  .##  ##.        WINDOWS SYSTEM MAINTENANCE TOOL
  ## / \ ##  /* *       by @dracula0x79  v1 ====> v2.0
  ## \ / ##
  '## v ##'
   '#####'

[1] Scan and repair system files
[2] Repair Windows issues (DISM)
[3] Check and fix disk errors
[4] Delete temporary files
[5] Flush DNS cache
[6] Run all tasks
[7] Update installed programs
[8] Help
[0] Exit
[!] version is outdated
Select an option:


```

## System Maintenance

* **System File Repair (SFC)** – Scan and fix corrupted Windows system files.
* **Windows Image Repair (DISM)** – Repair core Windows features and system health.
* **Disk Check & Repair (CHKDSK)** – Scan for and fix logical and physical disk errors.
* **Temporary Files Cleanup** – Free up storage by aggressively removing junk files and system temp data.
* **DNS Cache Flush** – Resolve internet connectivity and DNS-related issues quickly.
* **Software Update (Winget)** – Automatically upgrade all installed applications via Windows Package Manager.
* **Run All Maintenance** – Execute all standard cleanup and repair tasks in one automated sweep.

## Security Tools

* **Port & Process Monitor** – View active listening ports and established connections to spot suspicious network activity.
* **Windows Defender Full Scan** – Trigger a deep system scan directly from the command line.
* **Startup Inspector** – Check registry keys (HKCU/HKLM) and startup folders for potential malware persistence.
<img width="2880" height="1800" alt="Screenshot 2026-05-29 011502" src="https://github.com/user-attachments/assets/8c0f7526-4154-4136-8d66-e262f43f7e28" />

* **Scheduled Task Analyzer** – Filter and display non-Microsoft scheduled tasks to hunt for anomalies.
* **Account Auditor** – List all local users and administrators to detect unauthorized or hidden accounts.
<img width="2880" height="1800" alt="Screenshot 2026-05-29 011529" src="https://github.com/user-attachments/assets/6458bca9-80be-462e-9e48-522c7718f423" />


## Network Utilities

* **Full Network Reset** – Reset Winsock, IP stack, release/renew IPs, and flush DNS to fix severe networking issues.
* **DNS Switcher** – Quickly configure network adapters to use Cloudflare (1.1.1.1), Google (8.8.8.8), or restore to automatic DHCP.
* **Wi-Fi Password Dumper** – Extract and display cleartext passwords for all saved wireless networks, or look up a single network by name.
* **Network Share Scanner** – Reveal all shared folders on the local machine (including hidden `$` shares).
<img width="2880" height="1800" alt="Screenshot 2026-05-29 011551" src="https://github.com/user-attachments/assets/c1e7c41d-4b56-47c6-9d31-52da3dc4a6ea" />


## Power Tools & Admin

* **Process Killer** – Force-close unresponsive or malicious applications by executable name.
* **Service Controller** – Start, stop, disable, or enable Windows services on the fly.
* **Event Log Viewer** – Pull the last 24 hours of critical and error-level system logs for rapid troubleshooting.
<img width="2880" height="1800" alt="Screenshot 2026-05-29 011645" src="https://github.com/user-attachments/assets/b17f53b9-622a-48da-a7ac-275dcdba27a2" />

* **System Restore Point** – Create a safety backup snapshot before making significant system changes.
* **Performance Optimizer** – Disable visual animations and transparency effects to speed up the OS via registry tweaks.

## Help & Logging

* **[New] Interactive Help Menu** – Provides detailed, on-demand guidance on exactly when and how to use each specific tool.
* **Session Logging** – Automatically timestamps and records all executed actions to `maintenance_log.txt`.

## How to Use:
1. **Run as Administrator** (required for full functionality).
2. Select an option from the menu.
3. Follow the on-screen instructions.

## Download & Run:
1. Clone the repository:
```
git clone https://github.com/dracula0x79/DracMaintenanceTool.git
```
2. Navigate to the folder and run:

```
cd DracMaintenanceTool
.\DracUtility79.bat
or just right-click & run as Administrator
```
<img width="2880" height="1800" alt="Screenshot 2026-05-29 011418" src="https://github.com/user-attachments/assets/5a6184f9-a560-4f6a-8800-7d9a4e5418f6" />

