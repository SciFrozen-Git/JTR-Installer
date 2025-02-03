# **JTR-Installer**  
⚡ **A powerful, automated installer for [John the Ripper](https://www.openwall.com/john/) on Termux and Linux environments.**  

## **📌 Features**  
- ✅ Fully automated installation of **John the Ripper**  
- ✅ Checks and removes old installations before proceeding  
- ✅ Automatically updates and installs required dependencies  
- ✅ Intelligent retry mechanism for cloning repositories  
- ✅ Ensures **global accessibility** of `john` via `$PATH`  
- ✅ Works smoothly in **Termux** and standard **Linux environments**  

---

## **🚀 Installation & Usage**  

### **🔹 One-Line Installation**
Run the following command in **Termux** or a **Linux terminal**:  
```bash
curl -s https://raw.githubusercontent.com/unknown/JTR-Installer/main/JTR-Installer.sh | bash
```

## 🔹 Manual Installation  

1. **Clone the repository:**  
   ```
   git clone https://github.com/unknown/JTR-Installer.git
   cd JTR-Installer
   ```

2. Make the script executable:
```
   chmod +x JTR-Installer.sh
```
   
3. Run the installer:
```
   ./JTR-Installer.sh
```
   
---

## 🛠️ How It Works

1. Removes conflicting installations (if any).
2. Updates system packages to ensure compatibility.
3. Installs dependencies like git, build-essential, and binutils.
4. Clones the latest John the Ripper source from GitHub.
5. Builds and compiles the software.
6. Ensures john is globally accessible, even in Termux.

---

## ⚠️ Troubleshooting

### Error: Cannot find John home

> Run ```source ~/.bashrc``` or restart your terminal.

### Error: Permission denied for /usr/local/bin

> The script automatically adjusts by adding john to your $PATH.

Still facing issues? Open a GitHub issue!

---

## 📜 License

JTR-Installer is open-source and distributed under the MIT License.

---

## ⭐ Support the Project

If you find this project useful, consider starring ⭐ the repository on GitHub!
