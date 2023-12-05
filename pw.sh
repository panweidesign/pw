#!/bin/bash

while true; do
    echo "请选择要执行的操作："
    echo "0. 显示Ubuntu常用命令"
    echo "1. 安装aaPanel"
    echo "2. 安装Cloak"
    echo "3. 安装WireGuard"
    echo "4. 修改root密码"
    echo "5. 开放端口"
    echo "6. 更改SSH端口"
    echo "7. 更新系统"
    echo "8. 查看端口占用状态"
    echo "9. 显示系统信息"
    echo "10. 系统清理"
    echo "11. 安装Docker"
    echo "12. 创建系统快照"
    echo "13. 查看已安装的软件"
    echo "14. 卸载软件"
    echo "15. 安装curl"
    echo "16. 安装wget"
    echo "17. 安装iftop (网络流量监控工具)"
    echo "18. 重启系统"
    echo "19. 退出"
    read -p "请输入选项（0-19）: " choice

    case $choice in
        0)
           echo "Ubuntu常用命令："
           echo "  - 重启系统: sudo reboot"
           echo "  - 关闭系统: sudo shutdown -h now"
           echo "  - 编辑文件: nano <文件名> 或 vim <文件名>"
           echo "  - 进入路径: cd <路径>"
           echo "  - 查看当前路径: pwd"
           echo "  - 列出文件: ls"
           echo "  - 移动文件: mv <原文件路径> <新文件路径>"
           echo "  - 复制文件: cp <原文件路径> <新文件路径>"
           echo "  - 创建文件: touch <文件名>"
           echo "  - 创建目录: mkdir <目录名>"
           echo "  - 删除文件: rm <文件名>"
           echo "  - 删除目录: rm -r <目录名>"
           echo "  - 查找文件: find <路径> -name <文件名>"
           echo "  - 显示文件内容: cat <文件名>"
           echo "  - 查看系统信息: uname -a"
           echo "  - 查看磁盘使用情况: df -h"
           echo "  - 查看内存使用情况: free -h"
           echo "  - 使用bash: bash <脚本名>"
           echo "  - 使用curl: curl [选项] [URL]"
           echo "  - 使用wget: wget [选项] [URL]"
           echo "  - 使用&&连接命令"
           echo "  - 切换为root用户: sudo -i"
           ;;
        1)
           echo "正在安装aaPanel..."
           wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh aapanel
           ;;
        2)
           echo "正在安装Cloak..."
           curl -o Cloak-Installer.sh -L https://git.io/fj5mh && bash Cloak-Installer.sh
           ;;
        3)
           echo "正在安装WireGuard..."
           curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
           chmod +x wireguard-install.sh
           ./wireguard-install.sh
           ;;
        4)
           echo "请按提示操作以修改root密码"
           sudo passwd root
           ;;
        5)
           echo "请输入端口号（输入'all'以开放所有端口）:"
           read port
           if [ "$port" = "all" ]; then
               echo "正在开放所有端口..."
               sudo ufw disable
           else
               echo "正在开放端口 $port..."
               sudo ufw allow "$port"
           fi
           ;;
        6)
           echo "请输入新的SSH端口号:"
           read new_port
           echo "正在更改SSH端口为 $new_port..."
           sudo sed -i "s/#Port 22/Port $new_port/" /etc/ssh/sshd_config
           sudo systemctl restart sshd
           ;;
        7)
           echo "正在更新系统，请稍候..."
           sudo apt update && sudo apt upgrade -y
           ;;
        8)
           echo "当前端口占用状态如下："
           sudo lsof -i -P -n | grep LISTEN
           ;;
        9)
           echo "系统信息如下："
           hostnamectl
           ;;
        10)
           echo "正在进行系统清理..."
           sudo apt autoremove -y && sudo apt autoclean -y
           ;;
        11)
           echo "正在安装Docker..."
           sudo apt update
           sudo apt install -y docker.io
           sudo systemctl start docker
           sudo systemctl enable docker
           ;;
        12)
           echo "正在安装Timeshift并创建系统快照..."
           sudo apt install -y timeshift
           sudo timeshift --create --comments "Initial Snapshot" --tags D
           ;;
        13)
           echo "已安装的软件列表："
           dpkg --list
           ;;
        14)
           echo "请输入要卸载的软件包名称："
           read package_name
           echo "正在卸载 $package_name ..."
           sudo apt remove "$package_name"
           ;;
        15)
           echo "正在安装curl..."
           sudo apt install -y curl
           ;;
        16)
           echo "正在安装wget..."
           sudo apt install -y wget
           ;;
        17)
           echo "正在安装iftop..."
           sudo apt install -y iftop
           ;;
        18)
           echo "正在重启系统..."
           sudo reboot
           ;;
        19)
           break
           ;;
        *)
           echo "无效选项，请输入0-19之间的数字。"
           ;;
    esac

    read -p "操作完成。输入'00'返回主菜单，或输入任意其他键退出脚本: " back
    if [[ $back != "00" ]]; then
        break
    fi
done
