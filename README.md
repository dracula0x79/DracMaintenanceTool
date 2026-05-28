# DracUtility79 - Windows Maintenance Tool V2

DracUtility79 is a  batch script that helps automate common Windows maintenance tasks.  
I created this tool as part of my IT work to assist employees who often faced slow system performance and other issues.  

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
  ## / \ ##  /* *       by @dracula0x79  v1 ====> v2
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
* **Scheduled Task Analyzer** – Filter and display non-Microsoft scheduled tasks to hunt for anomalies.
* **Account Auditor** – List all local users and administrators to detect unauthorized or hidden accounts.

## Network Utilities

* **Full Network Reset** – Reset Winsock, IP stack, release/renew IPs, and flush DNS to fix severe networking issues.
* **DNS Switcher** – Quickly configure network adapters to use Cloudflare (1.1.1.1), Google (8.8.8.8), or restore to automatic DHCP.
* **Wi-Fi Password Dumper** – Extract and display cleartext passwords for all saved wireless networks, or look up a single network by name.
* **Network Share Scanner** – Reveal all shared folders on the local machine (including hidden `$` shares).

## Power Tools & Admin

* **Process Killer** – Force-close unresponsive or malicious applications by executable name.
* **Service Controller** – Start, stop, disable, or enable Windows services on the fly.
* **Event Log Viewer** – Pull the last 24 hours of critical and error-level system logs for rapid troubleshooting.
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

