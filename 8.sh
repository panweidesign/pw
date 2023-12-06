#!/bin/bash

while true; do
    echo "请选择要执行的操作："
    echo "0. 显示Ubuntu常用命令"
    echo "1. 启用SSH Root登录和密码认证"
    echo "2. 安装中文语言包并设置中文环境"
    echo "3. 安装aaPanel"
    echo "4. 安装Cloak"
    echo "5. 安装WireGuard"
    echo "6. 修改root密码"
    echo "7. 开放端口"
    echo "8. 更改SSH端口"
    echo "9. 更新系统"
    echo "10. 查看端口占用状态"
    echo "11. 显示系统信息"
    echo "12. 系统清理"
    echo "13. 安装Docker"
    echo "14. 重启系统"
    echo "15. 退出"
    read -p "请输入选项（0-15）: " choice

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
           echo "正在启用SSH Root登录和密码认证..."
           sudo sed -i 's/^PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
           sudo sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
           sudo sed -i 's/^ChallengeResponseAuthentication .*/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
           sudo systemctl restart sshd
           echo "SSH配置已更新。"
           ;;
        2)
           echo "正在安装中文语言包并设置中文环境..."
           sudo apt-get update
           sudo apt-get install language-pack-zh-hans
           sudo locale-gen zh_CN.UTF-8
           sudo update-locale LANG=zh_CN.UTF-8
           locale
           echo "中文环境设置完成。"
           ;;
        3)
           echo "正在安装aaPanel..."
           wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh aapanel
           ;;
        4)
           echo "正在安装Cloak..."
           curl -o Cloak-Installer.sh -L https://git.io/fj5mh && bash Cloak-Installer.sh
           ;;
        5)
           echo "正在安装WireGuard..."
           curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
           chmod +x wireguard-install.sh
           ./wireguard-install.sh
           ;;
        6)
           echo "请按提示操作以修改root密码"
           sudo passwd root
           ;;
        7)
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
        8)
           echo "请输入新的SSH端口号:"
           read new_port
           echo "正在更改SSH端口为 $new_port..."
           sudo sed -i "s/#Port 22/Port $new_port/" /etc/ssh/sshd_config
           sudo systemctl restart sshd
           ;;
        9)
           echo "正在更新系统，请稍候..."
           sudo apt update && sudo apt upgrade -y
           ;;
        10)
           echo "当前端口占用状态如下："
           sudo lsof -i -P -n | grep LISTEN
           ;;
        11)
           echo "系统信息如下："
           hostnamectl
           ;;
        12)
           echo "正在进行系统清理..."
           sudo apt autoremove -y && sudo apt autoclean -y
           ;;
        13)
           echo "正在安装Docker..."
           sudo apt update
           sudo apt install -y docker.io
           sudo systemctl start docker
           sudo systemctl enable docker
           ;;
        14)
           echo "正在重启系统..."
           sudo reboot
           ;;
        15)
           break
           ;;
        *)
           echo "无效选项，请输入0-15之间的数字。"
           ;;
    esac

    read -p "操作完成。输入'0'返回主菜单，或输入任意其他键退出脚本: " back
    if [[ $back != "0" ]]; then
        break
    fi
done
