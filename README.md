# ISO to MP4 PowerShell Automator

A high-performance PowerShell automation utility for batch converting DVD/Blu-ray ISO images into optimized MP4 files using HandBrakeCLI.

## 🚀 Overview

This script provides a seamless workflow for processing ISO image collections. It automates the transcoding process, manages file organization, and tracks processed files to ensure a clean migration from disc images to digital formats.

## ⚙️ Configuration

The script relies on a specific directory structure. You must define the following path variables in your PowerShell environment or at the beginning of the script:

```powershell
$GENERAL_DIR  =
$CSV_DIR      =
$ISO_DIR      =
$UPLOAD_DIR   =
$HANDBRAKE    =
$MIGRATED_DIR =
```

## 📁 File Classification

This script is designed to automatically organize your media library. Once the conversion is complete, files are moved to the upload directory (`$UPLOAD_DIR`) following this hierarchical structure[cite: 1, 2]:

- **Movies**: `uploads/movies/[category]/file.mp4`[cite: 2]
- **Series**: `uploads/series/[category]/file.mp4`[cite: 2]

This organization allows [sandres-cms](https://github.com/tu-usuario/sandres-cms) to detect and classify content immediately[cite: 2].

## 🚀 Integration with sandres-cms

This project has been specifically developed to work alongside **sandres-cms**[cite: 2]. The workflow ensures that every conversion meets the naming and location standards required by the CMS for proper display[cite: 2].

## 🛠️ Requirements and Installation

- **HandBrakeCLI**: Download the command-line version of HandBrake and place it in the path defined in `$HANDBRAKE`[cite: 1, 2].
- **PowerShell**: Ensure you have permissions to run scripts (`Set-ExecutionPolicy RemoteSigned`)[cite: 1, 2].
- **Configuration**: Create the `.env` file following the previous example[cite: 2].

## 📖 Usage

1.  Place your ISO files in the folder configured in `$ISO_DIR`[cite: 1, 2].
2.  Ensure the corresponding CSV files are in `$CSV_DIR`[cite: 2].
3.  Run the main script:
    ```powershell
    .\start-conversion.ps1
    ```
