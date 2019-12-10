===== 安装步骤 =====  

确保服务器时间准确  

wget https://github.com/DamageControlStudio/Downloads/raw/master/p7s_install/p7s.zip  
unzip -q p7s.zip  
sudo /bin/bash install.sh  

crontab -e  
- @reboot /bin/bash /usr/share/nginx/html/p7s_startup.sh  
- 0 8 * * *  /usr/share/nginx/html/p7s_env/bin/python /usr/share/nginx/html/p7s_cronclean.py  

rm install.sh <!-- 避免下次下载变成 install.sh.1 -->  

可选：  
- 通过 certbot 安装证书，配置 /etc/nginx/sites-available/default  
- 通过 CloudFlare 配置 https  
