#!/bin/bash

# Colors
GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[33m"
RED="\e[31m"
NO_COLOR="\e[0m"

# Print banner
echo -e "${GREEN}######  #     #    ######     #    #     # #     # ####### ###"
echo -e "#     #  #   #     #     #   # #   ##    # #  #  # #        #  "
echo -e "#     #   # #      #     #  #   #  # #   # #  #  # #        #  "
echo -e "######     #       ######  #     # #  #  # #  #  # #####    #  "
echo -e "#     #    #       #       ####### #   # # #  #  # #        #  "
echo -e "#     #    #       #       #     # #    ## #  #  # #        #  "
echo -e "######     #       #       #     # #     #  ## ##  ####### ###${NO_COLOR}"

echo -e "${BLUE}Ubuntu Server Management Script${NO_COLOR}"
echo -e "${YELLOW}Script provided by @duoduopan${NO_COLOR}"
echo -e "${YELLOW}YouTube Channel: https://www.youtube.com/@duoduopan${NO_COLOR}"
echo ""

# User confirmation
read -p 'Continue running the script? (y/n): ' user_choice
if [[ $user_choice != "y" && $user_choice != "Y" ]]; then
    echo -e "${RED}User chose to exit, script terminated.${NO_COLOR}"
    exit 0
fi

while true; do
    clear
    echo ""
    echo -e "${GREEN}========== Ubuntu Server Management Menu ==========${NO_COLOR}"
    echo -e "${BLUE}Please select an operation:${NO_COLOR}"
    echo ""
    echo -e " ${YELLOW}0.${NO_COLOR}  Show Ubuntu Common Commands"
    echo -e " ${YELLOW}1.${NO_COLOR}  Enable SSH Root Login & Password Authentication"
    echo -e " ${YELLOW}2.${NO_COLOR}  Install Chinese Language Pack"
    echo -e " ${YELLOW}3.${NO_COLOR}  Install aaPanel"
    echo -e " ${YELLOW}4.${NO_COLOR}  Install Cloak"
    echo -e " ${YELLOW}5.${NO_COLOR}  Install WireGuard"
    echo -e " ${YELLOW}6.${NO_COLOR}  Change Root Password"
    echo -e " ${YELLOW}7.${NO_COLOR}  Open Ports"
    echo -e " ${YELLOW}8.${NO_COLOR}  Change SSH Port"
    echo -e " ${YELLOW}9.${NO_COLOR}  Update System"
    echo -e " ${YELLOW}10.${NO_COLOR} Check Port Usage"
    echo -e " ${YELLOW}11.${NO_COLOR} Show System Information"
    echo -e " ${YELLOW}12.${NO_COLOR} System Cleanup"
    echo -e " ${YELLOW}13.${NO_COLOR} Install Docker"
    echo -e " ${YELLOW}14.${NO_COLOR} Restart System"
    echo -e " ${YELLOW}15.${NO_COLOR} Exit"
    echo ""
    echo -n "Please enter option (0-15): "
    read choice

    case $choice in
        0)
           echo -e "${GREEN}Ubuntu Common Commands:${NO_COLOR}"
           echo "  - Restart system: sudo reboot"
           echo "  - Shutdown system: sudo shutdown -h now"
           echo "  - Edit file: nano <filename> or vim <filename>"
           echo "  - Change directory: cd <path>"
           echo "  - Show current path: pwd"
           echo "  - List files: ls"
           echo "  - Move file: mv <source> <destination>"
           echo "  - Copy file: cp <source> <destination>"
           echo "  - Create file: touch <filename>"
           echo "  - Create directory: mkdir <dirname>"
           echo "  - Delete file: rm <filename>"
           echo "  - Delete directory: rm -r <dirname>"
           echo "  - Find file: find <path> -name <filename>"
           echo "  - Show file content: cat <filename>"
           echo "  - Show system info: uname -a"
           echo "  - Check disk usage: df -h"
           echo "  - Check memory usage: free -h"
           echo "  - Run bash script: bash <scriptname>"
           echo "  - Use curl: curl [options] [URL]"
           echo "  - Use wget: wget [options] [URL]"
           echo "  - Chain commands: use && between commands"
           echo "  - Switch to root: sudo -i"
           ;;
        1)
           echo -e "${BLUE}Enabling SSH Root login and password authentication...${NO_COLOR}"
           sudo sed -i 's/^#*PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
           sudo sed -i 's/^#*PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
           sudo sed -i 's/^#*ChallengeResponseAuthentication .*/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
           sudo systemctl restart sshd
           echo -e "${GREEN}SSH configuration updated successfully.${NO_COLOR}"
           ;;
        2)
           echo -e "${BLUE}Installing Chinese language pack and setting Chinese environment...${NO_COLOR}"
           sudo apt-get update
           sudo apt-get install -y language-pack-zh-hans
           sudo locale-gen zh_CN.UTF-8
           sudo update-locale LANG=zh_CN.UTF-8
           locale
           echo -e "${GREEN}Chinese environment setup completed.${NO_COLOR}"
           ;;
        3)
           echo -e "${BLUE}Installing aaPanel...${NO_COLOR}"
           wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh aapanel
           ;;
        4)
           echo -e "${BLUE}Installing Cloak...${NO_COLOR}"
           curl -o Cloak-Installer.sh -L https://git.io/fj5mh && bash Cloak-Installer.sh
           ;;
        5)
           echo -e "${BLUE}Installing WireGuard...${NO_COLOR}"
           curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
           chmod +x wireguard-install.sh
           ./wireguard-install.sh
           ;;
        6)
           echo -e "${BLUE}Please follow the prompts to change root password${NO_COLOR}"
           sudo passwd root
           ;;
        7)
           echo -n "Enter port number (enter 'all' to open all ports): "
           read port
           if [ "$port" = "all" ]; then
               echo -e "${BLUE}Opening all ports...${NO_COLOR}"
               sudo ufw disable
               echo -e "${GREEN}All ports opened (UFW disabled).${NO_COLOR}"
           else
               echo -e "${BLUE}Opening port $port...${NO_COLOR}"
               sudo ufw allow "$port"
               echo -e "${GREEN}Port $port opened successfully.${NO_COLOR}"
           fi
           ;;
        8)
           echo -n "Enter new SSH port number: "
           read new_port
           echo -e "${BLUE}Changing SSH port to $new_port...${NO_COLOR}"
           sudo sed -i "s/^#*Port .*/Port $new_port/" /etc/ssh/sshd_config
           sudo systemctl restart sshd
           echo -e "${GREEN}SSH port changed to $new_port successfully.${NO_COLOR}"
           echo -e "${YELLOW}Please reconnect using the new port.${NO_COLOR}"
           ;;
        9)
           echo -e "${BLUE}Updating system, please wait...${NO_COLOR}"
           sudo apt update && sudo apt upgrade -y
           echo -e "${GREEN}System update completed.${NO_COLOR}"
           ;;
        10)
           echo -e "${GREEN}Current port usage status:${NO_COLOR}"
           sudo lsof -i -P -n | grep LISTEN
           ;;
        11)
           echo -e "${GREEN}System Information:${NO_COLOR}"
           hostnamectl
           echo ""
           echo -e "${BLUE}CPU Information:${NO_COLOR}"
           lscpu | grep "Model name" || echo "CPU info not available"
           echo -e "${BLUE}Memory Information:${NO_COLOR}"
           free -h
           echo -e "${BLUE}Disk Information:${NO_COLOR}"
           df -h
           ;;
        12)
           echo -e "${BLUE}Performing system cleanup...${NO_COLOR}"
           sudo apt autoremove -y && sudo apt autoclean -y
           echo -e "${GREEN}System cleanup completed.${NO_COLOR}"
           ;;
        13)
           echo -e "${BLUE}Installing Docker...${NO_COLOR}"
           sudo apt update
           sudo apt install -y docker.io
           sudo systemctl start docker
           sudo systemctl enable docker
           echo -e "${GREEN}Docker installation completed.${NO_COLOR}"
           docker --version
           ;;
        14)
           echo -e "${YELLOW}System will restart in 5 seconds...${NO_COLOR}"
           echo -e "${RED}Press Ctrl+C to cancel${NO_COLOR}"
           for i in {5..1}; do
               echo -n "$i... "
               sleep 1
           done
           echo ""
           sudo reboot
           ;;
        15)
           echo -e "${GREEN}Thank you for using! Goodbye!${NO_COLOR}"
           exit 0
           ;;
        *)
           echo -e "${RED}Invalid option, please enter a number between 0-15.${NO_COLOR}"
           ;;
    esac

    echo ""
    echo -n "Operation completed. Press Enter to continue..."
    read
    echo -n "Enter '0' to return to main menu, or any other key to exit: "
    read back
    if [[ $back != "0" ]]; then
        echo -e "${GREEN}Script ended.${NO_COLOR}"
        exit 0
    fi
done
