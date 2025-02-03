# WinSysReport

A simple yet powerful Windows batch script that generates a comprehensive system report covering:

- **Operating System**: Basic system information (`systeminfo`)
- **CPU**: Name, cores, logical processors
- **Memory**: Capacity, manufacturer, speed
- **BIOS**: Manufacturer, name, version, release date
- **Motherboard**: Manufacturer, product, version, serial number
- **Graphics Card**: Name, driver version, RAM, processor
- **Network**: Complete IP configuration (`ipconfig /all`)
- **Logical Drives**: Filesystem, free space (GB), total size (GB)
- **Physical Disk Drives**: Model, interface, media type, serial number
- **Installed Programs**: Software name, version

## Table of Contents

- [About](#about)  
- [Preview](#preview)  
- [Usage](#usage)  
- [Customization](#customization)  
- [License](#license)  
- [Contributing](#contributing)

---

## About

**WinSysReport** is a single batch script (`.bat`) that consolidates multiple Windows command-line and PowerShell tools to gather detailed system hardware and software information. The script outputs everything to a single `SystemReport.txt` file for easy review and auditing.

---

## Preview

An example of the output you might see in `SystemReport.txt`:

```
===================================================
SYSTEM INFORMATION:
===================================================
Host Name:                YOUR-PC
OS Name:                  Microsoft Windows 10 Pro
OS Version:               10.0.19044 N/A Build 19044
System Type:              x64-based PC
...

====================================================
CPU INFORMATION:
(Properties are listed as Name=Value):
====================================================
Name=Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz
NumberOfCores=6
NumberOfLogicalProcessors=12
...

[...and so on...]
```

---

## Usage

1. **Download/Clone the Repository**  
   - [Clone the repo](https://github.com/yourusername/WinSysReport.git) or [download it as a zip](https://github.com/yourusername/WinSysReport/archive/refs/heads/main.zip).

2. **Locate the Batch File**  
   - Inside the repository, find the script: `SystemReport.bat`.

3. **Run the Script**  
   - Right-click on `SystemReport.bat` and select **Run as administrator**.  
   - The script automatically creates `SystemReport.txt` in the same folder.

4. **View the Report**  
   - Open `SystemReport.txt` to inspect the full hardware and software overview of your Windows system.

> **Note:** Some commands (especially those using `wmic` and certain PowerShell queries) may require administrator privileges to run properly.

---

## Customization

- **Sections**: You can remove or comment out sections you don’t need—e.g., if you’re not interested in BIOS data, simply remove or comment out the `BIOS INFORMATION` block.  
- **Output File Location**: Change the path of `outputfile` in the script if you want the report saved somewhere else.  
- **Formatting**: Adjust or rearrange the `echo` statements to customize how the final report is structured.

---

## License

This project is licensed under the [MIT License](LICENSE). You’re free to use, modify, and distribute this script; see the license file for details.

---

## Contributing

Contributions and suggestions are welcome! If you’d like to:

- **Report a Bug**: Please open an issue with details on how to reproduce it.
- **Suggest an Enhancement**: Open an issue or submit a pull request with a clear description of your idea.
- **Submit a Pull Request**: Fork the project, create a feature branch, commit your changes, and open a pull request to this repository.

Thank you for checking out **WinSysReport**! We hope you find it useful for quickly auditing and documenting Windows system details.

---

Happy auditing! If this script saves you time or helps you in any way, consider giving the repository a ⭐ on GitHub.
