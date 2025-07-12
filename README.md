🛠️ Bash Cyber Tools

All scripts in this repository were developed and executed entirely using Termux on a mobile phone as part of my self-learning journey in cybersecurity. This repo also contains my daily Bash scripting practice exercises, which I continuously update and improve.


---

📁 Tools List

🔹 cyberscan.sh

A simple network reconnaissance tool that can:

Check if a target is alive using ping

Perform a basic port scan with nmap

Save the results to a log file

Display the scan output in real-time



---

🔹 cyberscan_V1.sh

*An enhanced version of cyberscan.sh with these key improvements:

*Validates user input to ensure target and port fields are not empty

*Automatically generates timestamped log filenames to prevent overwriting

*Colored output (green for success, red for errors) for better readability

*Interactive prompt to view scan results using less

*Clear error messages when the target is unreachable

---

🔹 cyberscan_V2.sh

*A lightweight, interactive Bash script for network scanning using Nmap, optimized for Termux (Android) with no root required.

*Multiple scan modes: custom ports, top 1000, or full scan (1–65535)

*Input validation and automatic connectivity checks

*Service version detection (-sV)

*Logs saved with timestamps in a dedicated logs/ folder

*Highlights open ports in green for easy reading

*Interactive prompt to view full scan results


*Designed for smooth use on Android Termux without root access.

---

📌 Personal Notes

I’m learning Bash scripting as a foundation for cybersecurity. These tools are part of my daily practice and will be improved and expanded over time as my skills grow.


---

🪪 License

MIT License — Free to use, modify, and distribute.


---
