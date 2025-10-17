# 🍎 GBBS-2.x - Apple II BBS System

<div align="center">

![Apple II](https://img.shields.io/badge/Apple%20II-6502%2F65C02%2F65C816-blue?style=for-the-badge&logo=apple)
![Assembly](https://img.shields.io/badge/Assembly-6502-red?style=for-the-badge)
![ProDOS](https://img.shields.io/badge/ProDOS-Compatible-green?style=for-the-badge)
![License](https://img.shields.io/badge/License-GPL--3.0-green?style=for-the-badge)

**A complete Bulletin Board System (BBS) for Apple II series computers**

*Archive of GBBS Pro - The legendary BBS software that powered thousands of Apple II bulletin boards*

[🌐 Official Site](https://gbbs.applearchives.com) • [📖 Documentation](#documentation) • [🚀 Quick Start](#quick-start) • [📁 Source Code](#source-code)

</div>

---

## 📋 Table of Contents

- [About](#-about)
- [Features](#-features)
- [System Requirements](#-system-requirements)
- [Quick Start](#-quick-start)
- [Source Code](#-source-code)
- [Building](#-building)
- [Configuration](#-configuration)
- [Documentation](#-documentation)
- [History](#-history)
- [Contributing](#-contributing)
- [License](#-license)
- [Links](#-links)

---

## 🍎 About

**GBBS-2.x** is a comprehensive archive of the legendary **GBBS Pro** Bulletin Board System software for Apple II series computers. This BBS software was one of the most popular and feature-rich systems for Apple II users during the golden age of bulletin boards.

### What is GBBS Pro?

GBBS Pro was a professional-grade BBS system that supported:
- **Multiple users** with full user management
- **File transfers** with various protocols
- **Message boards** and email systems
- **Games and entertainment**
- **Multi-line support** for multiple simultaneous users
- **Professional features** for commercial BBS operations

---

## ✨ Features

### 🎯 Core BBS Features
- **Multi-user support** - Handle multiple simultaneous callers
- **Message system** - Public and private messaging
- **File transfers** - Support for various transfer protocols
- **User management** - Complete user account system
- **Security** - Access control and user validation

### 🎮 Entertainment
- **Built-in games** - Blackjack, Darts, Creature, and more
- **Interactive menus** - User-friendly interface
- **Customizable** - Extensive configuration options

### 🔧 Technical Features
- **6502/65C02/65C816** assembly language
- **ProDOS** compatible
- **Modular design** - Easy to customize and extend
- **Professional grade** - Used by commercial BBS operators

### 📡 Communication
- **Multiple modem support** - Various Hayes-compatible modems
- **Protocol support** - XMODEM, YMODEM, ZMODEM
- **Multi-line** - Support for multiple phone lines

---

## 💻 System Requirements

### Hardware
- **Apple II series computer** (IIe, IIc, IIGS)
- **64KB RAM minimum** (128KB+ recommended)
- **ProDOS compatible storage**
- **Modem** (Hayes-compatible recommended)
- **Printer** (optional)

### Software
- **ProDOS 1.x or 2.x**
- **Assembly language development tools** (for building from source)

---

## 🚀 Quick Start

### Using Pre-built Images
1. Download the distribution images from the `DISTRIBUTION IMAGES/` folder
2. Transfer to your Apple II system
3. Boot from the ProDOS disk
4. Follow the installation instructions

### From Source
1. Clone this repository
2. Set up your Apple II development environment
3. Build using the provided assembly source
4. See [Building](#-building) section for details

---

## 📁 Source Code

The source code is organized into several main directories:

```
SOURCE/
├── ACOS/           # Core BBS operating system
├── CONFIG/         # Configuration and drivers
├── GBBS.PRO.1/     # Main BBS system files
├── GBBS.PRO.2/     # Data files and menus
├── GBBS.PRO.3/     # Games and utilities
└── GBBS.PRO.4/     # File transfer protocols
```

### Key Components

| Component | Description |
|-----------|-------------|
| **ACOS** | Apple Computer Operating System - Core BBS engine |
| **CONFIG** | System configuration, drivers, and hardware support |
| **GBBS.PRO.1** | Main BBS system and user interface |
| **GBBS.PRO.2** | Data files, help system, and menus |
| **GBBS.PRO.3** | Games, utilities, and entertainment |
| **GBBS.PRO.4** | File transfer protocols and system utilities |

---

## 🔨 Building

### Prerequisites
- Apple II development environment
- 6502/65C02 assembler (Merlin, CA65, or similar)
- ProDOS development tools

### Build Process
1. Navigate to the `SOURCE/` directory
2. Configure your system in `CONFIG/`
3. Assemble the source files
4. Link the modules together
5. Create ProDOS disk images

*Detailed build instructions coming soon...*

---

## ⚙️ Configuration

GBBS Pro offers extensive configuration options:

- **Modem settings** - Support for various Hayes-compatible modems
- **Video modes** - 40-column and 80-column support
- **Printer support** - Various printer drivers
- **Clock support** - Multiple clock card options
- **User settings** - Customizable user experience

---

## 📖 Documentation

- **Official Documentation**: [Call-A.P.P.L.E. GBBS Site](https://gbbs.applearchives.com)
- **Source Code**: Well-commented assembly source
- **Configuration**: See `CONFIG/` directory for setup options

---

## 📜 History

GBBS Pro was one of the most successful BBS systems for the Apple II platform, used by thousands of bulletin board operators worldwide. This archive preserves the complete source code and documentation for historical and educational purposes.

### Timeline
- **1980s-1990s**: Golden age of BBS systems
- **GBBS Pro**: One of the premier Apple II BBS systems
- **Today**: Preserved for historical and educational use

---

## 🤝 Contributing

This is an archive of historical software. Contributions are welcome for:
- Documentation improvements
- Build system enhancements
- Historical context and stories
- Bug fixes and compatibility improvements

Please respect the GPL-3.0 licensing terms and Kevin M. Smallwood's copyright.

---

## 📄 License

This software is licensed under the **GNU General Public License v3.0** (GPL-3.0).

**Copyright**: All rights reserved by **Kevin M. Smallwood** (1986-2024)

This is an archive of historical software preserved for educational and historical purposes. The complete source code is available under the terms of the GPL-3.0 license. Please refer to `LICENSE.TXT` for the full license text.

**Note**: This software was originally commercial but is now available under open source licensing. Please respect the GPL-3.0 terms and Kevin M. Smallwood's copyright.

---

## 🔗 Links

- 🌐 **Official Site**: [Call-A.P.P.L.E. GBBS](https://gbbs.applearchives.com)
- 📚 **Apple II Archives**: [applearchives.com](https://applearchives.com)
- 🍎 **Apple II Community**: Various Apple II enthusiast sites
- 📖 **BBS History**: Learn about the golden age of bulletin boards

---

<div align="center">

**Made with ❤️ for the Apple II community**

*Preserving the legacy of Apple II BBS systems*

</div>
