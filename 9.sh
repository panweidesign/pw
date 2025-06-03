#!/bin/bash

# Colors / 颜色定义
GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[33m"
RED="\e[31m"
NO_COLOR="\e[0m"

# Print banner / 打印横幅
echo -e "${GREEN}######  #     #    ######     #    #     # #     # ####### ###"
echo -e "#     #  #   #     #     #   # #   ##    # #  #  # #        #  "
echo -e "#     #   # #      #     #  #   #  # #   # #  #  # #        #  "
echo -e "######     #       ######  #     # #  #  # #  #  # #####    #  "
echo -e "#     #    #       #       ####### #   # # #  #  # #        #  "
echo -e "#     #    #       #       #     # #    ## #  #  # #        #  "
echo -e "######     #       #       #     # #     #  ## ##  ####### ###${NO_COLOR}"

echo -e "${BLUE}Ubuntu Server Management Script / Ubuntu服务器管理脚本${NO_COLOR}"
echo -e "${YELLOW}Script provided by @duoduopan | 脚本由@duoduopan提供${NO_COLOR}"
echo -e "${YELLOW}YouTube Channel: https://www.youtube.com/@duoduopan${NO_COLOR}"
echo ""

# User confirmation / 用户确认
read -p 'Continue running the script? / 是否继续运行脚本？ (y/n): ' user_choice
if [[ $user_choice != "y" && $user_choice != "Y" ]]; then
    echo -e "${RED}User chose to exit, script terminated. / 用户选择退出，脚本终止。${NO_COLOR}"
    exit 0
fi

while true; do
    echo ""
    echo -e "${GREEN}========== Ubuntu Server Management Menu / Ubuntu服务器管理菜单 ==========${NO_COLOR}"
    echo -e "${BLUE}Please select an operation / 请选择要执行的操作：${NO_COLOR}"
    echo ""
    echo -e " ${YELLOW}0.${NO_COLOR}  Show Ubuntu Common Commands / 显示Ubuntu常用命令"
    echo -e " ${YELLOW}1.${NO_COLOR}  Enable SSH Root Login & Password Auth / 启用SSH Root登录和密码认证"
    echo -e " ${YELLOW}2.${NO_COLOR}  Install Chinese Language Pack / 安装中文语言包并设置中文环境"
    echo -e " ${YELLOW}3.${NO_COLOR}  Install aaPanel / 安装aaPanel"
    echo -e " ${YELLOW}4.${NO_COLOR}  Install Cloak / 安装Cloak"
    echo -e " ${YELLOW}5.${NO_COLOR}  Install WireGuard / 安装WireGuard"
    echo -e " ${YELLOW}6.${NO_COLOR}  Change Root Password / 修改root密码"
    echo -e " ${YELLOW}7.${NO_COLOR}  Open Ports / 开放端口"
    echo -e " ${YELLOW}8.${NO_COLOR}  Change SSH Port / 更改SSH端口"
    echo -e " ${YELLOW}9.${NO_COLOR}  Update System / 更新系统"
    echo -e " ${YELLOW}10.${NO_COLOR} Check Port Usage / 查看端口占用状态"
    echo -e " ${YELLOW}11.${NO_COLOR} Show System Information / 显示系统信息"
    echo -e " ${YELLOW}12.${NO_COLOR} System Cleanup / 系统清理"
    echo -e " ${YELLOW}13.${NO_COLOR} Install Docker / 安装Docker"
    echo -e " ${YELLOW}14.${NO_COLOR} Restart System / 重启系统"
    echo -e " ${YELLOW}15.${NO_COLOR} Exit / 退出"
    echo ""
    read -p "Please enter option (0-15) / 请输入选项（0-15）: " choice

    case $choice in
        0)
           echo -e "${GREEN}Ubuntu Common Commands / Ubuntu常用命令：${NO_COLOR}"
           echo "  - Restart system / 重启系统: sudo reboot"
           echo "  - Shutdown system / 关闭系统: sudo shutdown -h now"
           echo "  - Edit file / 编辑文件: nano <filename> 或 vim <filename>"
           echo "  - Change directory / 进入路径: cd <path>"
           echo "  - Show current path / 查看当前路径: pwd"
           echo "  - List files / 列出文件: ls"
           echo "  - Move file / 移动文件: mv <source> <destination>"
           echo "  - Copy file / 复制文件: cp <source> <destination>"
           echo "  - Create file / 创建文件: touch <filename>"
           echo "  - Create directory / 创建目录: mkdir <dirname>"
           echo "  - Delete file / 删除文件: rm <filename>"
           echo "  - Delete directory / 删除目录: rm -r <dirname>"
           echo "  - Find file / 查找文件: find <path> -name <filename>"
           echo "  - Show file content / 显示文件内容: cat <filename>"
           echo "  - Show system info / 查看系统信息: uname -a"
           echo "  - Check disk usage / 查看磁盘使用情况: df -h"
           echo "  - Check memory usage / 查看内存使用情况: free -h"
           echo "  - Run bash script / 使用bash: bash <scriptname>"
           echo "  - Use curl / 使用curl: curl [options] [URL]"
           echo "  - Use wget / 使用wget: wget [options] [URL]"
           echo "  - Chain commands / 使用&&连接命令"
           echo "  - Switch to root / 切换为root用户: sudo -i"
           ;;
        1)
           echo -e "${BLUE}Enabling SSH Root login and password authentication... / 正在启用SSH Root登录和密码认证...${NO_COLOR}"
           sudo sed -i 's/^PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
           sudo sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
           sudo sed -i 's/^ChallengeResponseAuthentication .*/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
           sudo systemctl restart sshd
           echo -e "${GREEN}SSH configuration updated successfully. / SSH配置已更新。${NO_COLOR}"
           ;;
        2)
           echo -e "${BLUE}Installing Chinese language pack and setting Chinese environment... / 正在安装中文语言包并设置中文环境...${NO_COLOR}"
           sudo apt-get update
           sudo apt-get install -y language-pack-zh-hans
           sudo locale-gen zh_CN.UTF-8
           sudo update-locale LANG=zh_CN.UTF-8
           locale
           echo -e "${GREEN}Chinese environment setup completed. / 中文环境设置完成。${NO_COLOR}"
           ;;
        3)
           echo -e "${BLUE}Installing aaPanel... / 正在安装aaPanel...${NO_COLOR}"
           wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh aapanel
           ;;
        4)
           echo -e "${BLUE}Installing Cloak... / 正在安装Cloak...${NO_COLOR}"
           curl -o Cloak-Installer.sh -L https://git.io/fj5mh && bash Cloak-Installer.sh
           ;;
        5)
           echo -e "${BLUE}Installing WireGuard... / 正在安装WireGuard...${NO_COLOR}"
           curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
           chmod +x wireguard-install.sh
           ./wireguard-install.sh
           ;;
        6)
           echo -e "${BLUE}Please follow the prompts to change root password / 请按提示操作以修改root密码${NO_COLOR}"
           sudo passwd root
           ;;
        7)
           echo -e "Enter port number (enter 'all' to open all ports) / 请输入端口号（输入'all'以开放所有端口）:"
           read port
           if [ "$port" = "all" ]; then
               echo -e "${BLUE}Opening all ports... / 正在开放所有端口...${NO_COLOR}"
               sudo ufw disable
               echo -e "${GREEN}All ports opened (UFW disabled). / 所有端口已开放（UFW已禁用）。${NO_COLOR}"
           else
               echo -e "${BLUE}Opening port $port... / 正在开放端口 $port...${NO_COLOR}"
               sudo ufw allow "$port"
               echo -e "${GREEN}Port $port opened successfully. / 端口 $port 开放成功。${NO_COLOR}"
           fi
           ;;
        8)
           echo -e "Enter new SSH port number / 请输入新的SSH端口号:"
           read new_port
           echo -e "${BLUE}Changing SSH port to $new_port... / 正在更改SSH端口为 $new_port...${NO_COLOR}"
           sudo sed -i "s/#Port 22/Port $new_port/" /etc/ssh/sshd_config
           sudo sed -i "s/Port 22/Port $new_port/" /etc/ssh/sshd_config
           sudo systemctl restart sshd
           echo -e "${GREEN}SSH port changed to $new_port successfully. / SSH端口已成功更改为 $new_port。${NO_COLOR}"
           echo -e "${YELLOW}Please reconnect using the new port. / 请使用新端口重新连接。${NO_COLOR}"
           ;;
        9)
           echo -e "${BLUE}Updating system, please wait... / 正在更新系统，请稍候...${NO_COLOR}"
           sudo apt update && sudo apt upgrade -y
           echo -e "${GREEN}System update completed. / 系统更新完成。${NO_COLOR}"
           ;;
        10)
           echo -e "${GREEN}Current port usage status / 当前端口占用状态如下：${NO_COLOR}"
           sudo lsof -i -P -n | grep LISTEN
           ;;
        11)
           echo -e "${GREEN}System Information / 系统信息如下：${NO_COLOR}"
           hostnamectl
           echo ""
           echo -e "${BLUE}CPU Information / CPU信息：${NO_COLOR}"
           lscpu | grep "Model name"
           echo -e "${BLUE}Memory Information / 内存信息：${NO_COLOR}"
           free -h
           echo -e "${BLUE}Disk Information / 磁盘信息：${NO_COLOR}"
           df -h
           ;;
        12)
           echo -e "${BLUE}Performing system cleanup... / 正在进行系统清理...${NO_COLOR}"
           sudo apt autoremove -y && sudo apt autoclean -y
           echo -e "${GREEN}System cleanup completed. / 系统清理完成。${NO_COLOR}"
           ;;
        13)
           echo -e "${BLUE}Installing Docker... / 正在安装Docker...${NO_COLOR}"
           sudo apt update
           sudo apt install -y docker.io
           sudo systemctl start docker
           sudo systemctl enable docker
           echo -e "${GREEN}Docker installation completed. / Docker安装完成。${NO_COLOR}"
           docker --version
           ;;
        14)
           echo -e "${YELLOW}Restarting system in 5 seconds... / 系统将在5秒后重启...${NO_COLOR}"
           echo -e "${RED}Press Ctrl+C to cancel / 按Ctrl+C取消${NO_COLOR}"
           sleep 5
           sudo reboot
           ;;
        15)
           echo -e "${GREEN}Thank you for using! Goodbye! / 感谢使用！再见！${NO_COLOR}"
           break
           ;;
        *)
           echo -e "${RED}Invalid option, please enter a number between 0-15. / 无效选项，请输入0-15之间的数字。${NO_COLOR}"
           ;;
    esac

    echo ""
    read -p "Operation completed. Enter '0' to return to main menu, or any other key to exit / 操作完成。输入'0'返回主菜单，或输入任意其他键退出脚本: " back
    if [[ $back != "0" ]]; then
        echo -e "${GREEN}Script ended. / 脚本结束。${NO_COLOR}"
        break
    fi
done
