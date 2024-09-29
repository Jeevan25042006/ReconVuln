Network Recon Tool

The Network Recon Tool is a Bash script designed to enhance network security by identifying live devices, scanning for open ports, and detecting vulnerabilities in services. This tool is ideal for cybersecurity professionals and network administrators looking to assess their network's security posture.

 Features

- Live Host Detection: Quickly identifies active devices in the network.
- Port Scanning: Scans for open ports, revealing potential entry points for attackers.
- Service Identification: Detects running services on open ports and their versions.
- Vulnerability Assessment: Utilizes tools like Searchsploit to identify known vulnerabilities associated with detected services.

Requirements

- Nmap: For network discovery and security auditing. You can install it using:
  - Debian/Ubuntu: `sudo apt-get install nmap`
  - CentOS/Fedora: `sudo yum install nmap`
- Searchsploit**: For vulnerability identification. It comes with the `exploitdb` package, which can be installed via:
  - Debian/Ubuntu: `sudo apt-get install exploitdb`

How to Use

1. Clone the Repository: Use the following command to clone the repository to your local machine:

   
