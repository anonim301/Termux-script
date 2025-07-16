---

🛠️ Bash Cyber Tools

All scripts in this repo were built and tested entirely in Termux (Android) as part of my self-learning journey in cybersecurity and Bash scripting. I update these tools regularly as my skills grow.


---

📁 Tools Overview

🔹 cyberscan.sh

Basic Nmap-based port scanner with:

Ping check

Simple port scan

Realtime output + log saving



---

🔹 cyberscan_V1.sh

Enhanced version with:

Input validation (target/port)

Timestamped log filenames

Colored terminal output (✅ / ❌)

View scan results via less



---

🔹 cyberscan_V2.sh

Fully interactive network scanner:

Scan modes: custom, top 1000, full

Auto ping & input checks

Service detection (-sV)

Logs in /logs folder

Open ports shown in green



---

🔹 cyberscan_V3.sh

Major upgrade with:

Regex-based IP/domain validation

Optional scan continuation if ping fails (Cloudflare-friendly)

Optional extended scan (-sC)

Interactive prompts

Spinner (fake loading)

Figlet + lolcat banner



---

📌 Notes

This is my practice ground for learning Bash + CyberSec basics. All tools are designed for Termux (no root) and mobile-friendly.


---

🪪 License

MIT License — free to use, modify, and share.

---

