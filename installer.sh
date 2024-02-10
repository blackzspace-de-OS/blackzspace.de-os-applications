#!/bin/bash
# installer.sh

# Author: BlackLeakz
# Version: 0.1 BETA
# Github: https://github.com/blackzspace-de-OS/blackzspace.de-os-applications
# Website: https://blackzspace.de/OS

reset;


me=$(whoami)
if [ "$me" != "root" ]; then
    echo " > You must be root to do this."
    exit 1
fi
export a="apt-get -y install "
export g="git clone "

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

mkdir ~/.tmp
cd ~/.tmp


function auto_install() {
   read -p "Console > Do you want to install all applications? [y/n] " yn
   case $yn in
       [Yy]* ) echo " > Starting auto install..."; continue;;
       [Nn]* ) echo " > Aborted auto install."; menu;;
       * ) echo " > Please answer yes or no."; continue;;
   esac

   if [ "$OS" == "Ubuntu" or "Debian" ]; then
       echo " > Installing applications for Ubuntu..."
        install_build_tools;

       install_pentest_tools;
       install_network_tools;

   
   
}


function install_build_tools() {
    echo -e " > Installing build tools..."
    $a make cmake build-essential sof*prop*c* 
    $a python3-dev python3-pip python3-venv 
    $a git curl wget gzip
    $a apt-transport-https
    
}


function install_pentest_tools() {
    echo -e " > Installing pentest tools..."
    install_network_tools;
    $a nmap aircrack-ng macchanger
    $a openjdk-11-jdk
    

wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
sudo apt-get update
sudo apt-get install neo4j=1:5.16.0
sudo systemctl stop neo4j
cd /usr/bin
sudo ./neo4j console
cd /usr/bin
./neo4j console
wget https://github.com/BloodHoundAD/BloodHound/releases/download/v4.3.1/BloodHound-linux-x64.zip
unzip BloodHound-linux-x64.zip
unzip *.zip

$a hydra hydra-gtk john john-data
$a sqlmap burpsuite 
$a fuff
$a responder
$a bettercap
$a ettercap
$a etherape
$a wireshark
$a tshark
$a sshuttle





    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

}




function install_network_tools() {
    echo -e " > Installing network tools..."
    $a net-tools traceroute whois nmap 
}






function menu() {
echo "======================================================="
echo "== blackzspace.de - OS || Installer v0.1             =="
echo "======================================================="
echo "== 1: (A)uto install   || 2: (M)anual install        =="
echo "== 3: (I)nstall IDE's  || 4: Install (N)etwork Tools =="
echo "== 5: (P)entest Tools  || 6: (B)uild Tools           =="
echo "======================================================="
echo "======================================================="
echo "== Press CTRL + C or enter q to quit ! || (m) Menu   =="
echo "======================================================="

while true;
do
read -p "Console > " choice

case $choice in 
    1) auto_install ;; continue;;
    2) manual_install ;; continue;;
    3) install_ides ;; continue;;
    4) install_network_tools ;; continue;;
    5) install_pentest_tools ;; continue;;
    6) install_build_tools ;; continue;;
    m) menu ;; continue;;
    q) exit 0 ;; continue;;
    *) echo " > Invalid option, please try again." ;; continue;;
esac
done
}