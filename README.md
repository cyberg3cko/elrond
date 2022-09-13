<!-- PROJECT LOGO -->
<p align="center">
  <a href="https://github.com/ezaspy/elrond">
    <img src="elrond/images/logo_trans_big.png" alt="Logo" width="400" height="400">
  </a>
  <p align="center">
    Accelerating the collection, processing, analysis and outputting of digital forensic artefacts.
    <br><br>
    <a href="https://mit-license.org">
      <img src="https://img.shields.io/github/license/ezaspy/elrond" alt="License: MIT">
    </a>
    <a href="https://github.com/ezaspy/elrond/issues">
      <img src="https://img.shields.io/github/issues/ezaspy/elrond" alt="Issues">
    </a>
    <a href="https://github.com/ezaspy/elrond/network/members">
      <img src="https://img.shields.io/github/forks/ezaspy/elrond" alt="Forks">
    <a href="https://github.com/ezaspy/elrond/stargazers">
      <img src="https://img.shields.io/github/stars/ezaspy/elrond" alt="Stars">
    </a>
    <a>
      <img src="https://img.shields.io/badge/subject-DFIR-red" alt="Subject">
    </a>
    </a>
      <img src="https://img.shields.io/github/last-commit/ezaspy/elrond" alt="Last Commit">
    </a>
    <a href="https://github.com/psf/black">
      <img alt="Code style: black" src="https://img.shields.io/badge/code%20style-black-000000.svg">
    </a>
    <br><br>
  </p>
</p>

<!-- TABLE OF CONTENTS -->

## Table of Contents

- [About the Project](#about-the-project)
  - [Related Projects](#related-projects)
- [Configuration](#configuration)
  - [SANS SIFT Workstation](https://digital-forensics.sans.org/community/downloads)
  - [CONFIG.md](https://github.com/ezaspy/elrond/blob/main/elrond/CONFIG.md)
- [Usage](#usage)
- [Contributing](#contributing)
  - [Contact](#contact)
- [Acknowledgements](#acknowledgements)

<br><br>

<!-- ABOUT -->

## About The Project

elrond has been created to help fellow digitial forensicators with the identification, extraction, collection, processing, analysis and outputting of forensic artefacts from (up to 20 paritions for) Windows E01 or VMDK, macOS DMG/E01 or VMDK, Linux dd or VMDK disk images as well as raw memory images and previously collected artefacts which can all be outputted into Splunk. I have spent many an incident repeating the same processes by mounting, collecting (mainly Windows) forensic artefacts and then attempting to correlate them together with other data sources and artefacts. Thus, as mentioned above elrond has been built to consolidate those seperate processes into one single script helping to accerlate and automate these otherwise repetitive, tedious and often occasionally-referenced commands. As elrond outputs the artefact information as either CSV or JSON, they can be processed by many commonly-used log file analysis tools, consequently, elrond does have the capability to stand up a local [Splunk](https://www.splunk.com/) or [elastic](https://www.elastic.co/) instance, whereby the artefacts are automatically assigned and aligned with the [MITRE ATT&CK® Framework](https://attack.mitre.org/). In addition, elrond can also populate a local [ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) instance providing a visual representation of potential attack techniques leveraged as part of said incident.<br>
Additional features include image and file hashing, metadata extraction, file recovery and carving, AV scanning, IOC extraction, keyword searching and timelining.<br>

### Related Projects

elrond is responsible for the analysis-side of digital forensic, but what about acquisition? An acompanying script called [gandalf](https://github.com/ezaspy/gandalf) can be deployed (locally or remotely) on either Windows (PowerShell), macOS or Linux (Python) hosts to acquire forensic artefacts. 
<br><br><br>

<!-- PREREQUISITES -->

## Configuration

There are several software package required for using elrond but almost all of them are contained within the [SANS SIFT Worksation](https://www.sans.org/tools/sift-workstation/) virtual machine OVA. However, for the software which is not included, I have provided a script ([make.sh](https://github.com/ezaspy/elrond/blob/main/make.sh)) which installs and configures the additional software required for all potential functionality leveraged by elrond (volatility3, apfs-fuse, ClamAV etc.).<br>
To invoke the script, simply follow the instructions in [CONFIG.md](https://github.com/ezaspy/elrond/blob/main/elrond/CONFIG.md#configuration). **Please note, you will only need to run the make.sh script once, per SIFT instance**

- [SANS SIFT Workstation](https://digital-forensics.sans.org/community/downloads) (20.04)
  - Note: SANS SIFT 18.04 is not supported.
- [CONFIG.md](https://github.com/ezaspy/elrond/blob/main/elrond/CONFIG.md) to install and configure the additional software for SIFT 20.04.
  - Please note the elrond also only supports x64 memory images.
  - If you encounter errors with [CONFIG.md](https://github.com/ezaspy/elrond/blob/main/elrond/CONFIG.md), individual scripts for each of the software packages are contained in [.../elrond/elrond/tools/scripts/](https://github.com/ezaspy/elrond/tree/main/elrond/tools/scripts/)
<br><br><br>

<!-- USAGE EXAMPLES -->

## Usage

`python3 elrond.py <case_id> <directory> [<output_directory>] [-h] [-AaBCcDEGHIiMoPpQqRSsTtUVvZ] [-K <keyword_file>] [-Y <yara_dir>] -F (include|exclude):[<include/exclude_file>]`

<br>

### Collect (-C)<br>
#### Examples<br>

- Invoking DBM (-B) flag (instead of using -acINoPQqUVv), Process (**-P**) index artefacts in Splunk (**-S**) and conduct File Collection (-F) with inclusion list<br>

`python3 elrond.py case_name /path/to/disk/images -BCPS  -F include:./include_file.txt`

- Automatically (**-a**) and super-quietly (**-Q**) Collect (**-C**), Process (**-P**), Analyse (**-A**) and index artefacts (including memory (**-M**)) in Splunk (**-S**)<br>

`python3 elrond.py case_name /path/to/disk_and_memory/images -aqQvVMCPAS`

- Very verbosely (**-V**), automatically (**-a**), super-quietly (**-Q**) Collect (**-C**), Process (**-P**) and conduct IOC Extraction (**-I**)<br>

`python3 elrond.py case_name /path/to/disk/images -avVqQCPI`
<br><br>

### Gandalf (-G)<br>
#### Examples<br>

- Automatically (**-a**) and superquietly (**-Q**) Process (**-P**), Analyse (**-A**) and index artefacts in Splunk (**-S**) (acquired using [gandalf](https://github.com/ezaspy/gandalf))<br>

`python3 elrond.py case_name /path/to/disk/images -aqvVGPAS`

- Invoking DBM (-B) flag (instead of using -acINoPQqUVv), Process (**-P**) index artefacts in Splunk (**-S**) and conduct Keyword Searching (-K <file_name>)<br>

`python3 elrond.py case_name /path/to/disk/images -BGPS -K keywords.txt`
<br><br>


### Reorganise (-R)<br>
#### Examples<br>

- Automatically (**-a**) and quietly (**-q**) Process (**-P**), Analyse (**-A**) and index artefacts in Splunk (**-S**) (reorganise previously collected disk artefacts (**-R**))<br>

`python3 elrond.py case_name /path/to/disk/images -aqvVRPAS`

- Invoking DBM (-B) flag (instead of using -acINoPQqUVv), Process (**-P**) index artefacts in Splunk (**-S**) and conduct Yara Searching (-Y <yara_dir>)<br>

`python3 elrond.py case_name /path/to/disk/images -BRPS -Y <directory/of/yara/files>`
<br><br>

### Support

See the [support file](https://github.com/ezaspy/elrond/SUPPORT.md) for a list of commands and additional third-party tools to help with preparing images or data for elrond.
<br><br>

### Notices

Please note that if you notice 'nixCommand' or 'nixProcess' in files processed from a Windows OS, this is somewhat intentional. I debated with myself whether to try and change these to 'WinCommand' and 'WinProcess', respectively but also considered the situation of Windows Subsystem for Linux (WSL) being installed. As a result, I have left them as they are. If you know of a way to identify whether a file belongs inside the Linux element of WSL based on file path, file type, file content etc. please raise an [issue](https://github.com/ezaspy/elrond/issues) and let me know.
<br><br><br>

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
<br><br>

### Contact

ezaspy - ezaspython (at) gmail (dot) com
<br><br><br>

<!-- ACKNOWLEDGEMENTS -->

## Acknowledgements

- [Joff Thyor](https://www.blackhillsinfosec.com/team/joff-thyer/)
- [alexandercarruthers](https://github.com/alexandercarruthers)
- [SANS](https://www.sans.org)
- [Harbingers LLC](https://uspto.report/company/Harbingers-L-L-C)<br><br>
- Tooling
  - [joachimmetz](https://github.com/joachimmetz)
  - [Harlan Carvey](https://github.com/hcarvey)
  - [williballenthin](https://github.com/williballenthin)
  - [dkovar](https://github.com/dkovar)
  - [Richard Penman](https://github.com/richardpenman)
  - [harelsegev](https://github.com/harelsegev/INDXRipper)
  - [mnrkbys](https://github.com/mnrkbys/macosac)
  - [The Volatility Foundation](https://github.com/volatilityfoundation)
  - [AVML](https://github.com/microsoft/avml)
  - [Jonathon Poling](https://ponderthebits.com/2017/02/osx-mac-memory-acquisition-and-analysis-using-osxpmem-and-volatility/)
  - [@binaryz0ne](https://www.binary-zone.com/2019/06/20/acquiring-linux-memory-using-avml-and-using-it-with-volatility/)
  - [JPCERTCC](https://github.com/JPCERTCC/Windows-Symbol-Tables)
  - [John - Python Awesome](https://pythonawesome.com/windows-symbol-tables-for-volatility-3-in-python/)<br><br>
- Documentation
  - [Best-README-Template](https://github.com/othneildrew/Best-README-Template)
  - [hatchful](https://hatchful.shopify.com)
  - [Image Shields](https://shields.io)<br><br>
- Theme &amp; Artwork
  - [J.R.R. Tolkien](https://en.wikipedia.org/wiki/J._R._R._Tolkien)
  - [Peter Jackson](https://twitter.com/ReaPeterJackson)
  - [ASCII Text Generator](https://textkool.com/en/ascii-art-generator?hl=default&vl=default&font=Red%20Phoenix&text=Your%20text%20here%20)
  - [ASCII Art Generator](https://www.ascii-art-generator.org)
  - [ASCII Art](http://www.asciiworld.com/-Lord-of-the-Rings-.html)
  - [SIFT-elrond Desktop background](https://www.hdwallpaper.nu/wp-content/uploads/2015/04/rings_the_lord_of_the_rings_one_ring_hd_wallpaper.jpg)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[elrond-screenshot]: images/screenshot.png