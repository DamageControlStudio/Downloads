确保服务器时间准确  
wget https://github.com/DamageControlStudio/Downloads/raw/master/p7s_install/install.sh  
wget https://github.com/DamageControlStudio/Downloads/raw/master/p7s_install/p7s.zip  
sudo /bin/bash install.sh  
crontab -e  
- @reboot /bin/bash /usr/share/nginx/html/p7s_startup.sh  
- 0 8 * * *  /usr/share/nginx/html/p7s_env/bin/python /usr/share/nginx/html/p7s_cronclean.py  
