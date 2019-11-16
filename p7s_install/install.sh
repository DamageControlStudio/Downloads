#!/bin/bash

# 解压安装包
unzip -q p7s.zip

# 清理残存数据
rm /usr/share/nginx/html/p7s_sqlite.db
rm -rf /usr/share/nginx/html/files
rm -rf /usr/share/nginx/html/p7s_env

# 安装必要环境
apt-get update
apt-get install nginx python-virtualenv ffmpeg

# 创建工作文件夹
mkdir /usr/share/nginx/html/templates
mkdir /usr/share/nginx/html/files
mkdir /usr/share/nginx/html/logs

# 所谓安装：众神归位
mv p7s_init.py /usr/share/nginx/html/p7s_init.py
mv p7s_main.py /usr/share/nginx/html/p7s_main.py
mv p7s_download.py /usr/share/nginx/html/p7s_download.py
mv p7s_utils.py /usr/share/nginx/html/p7s_utils.py
mv p7s_startup.sh /usr/share/nginx/html/p7s_startup.sh
mv templates/status.html /usr/share/nginx/html/templates/status.html
mv templates/welcome.html /usr/share/nginx/html/templates/welcome.html

# 删除没用的文件
rm p7s.zip
rm -rf __MAXOSX
rm -rf templates

# 创建虚拟环境 p7s_env 
cd /usr/share/nginx/html
virtualenv --no-site-packages p7s_env --python=python3
source p7s_env/bin/activate

# 安装必要环境
pip install -U gunicorn flask youtube-dl

# 配置 nginx
cat > /etc/nginx/sites-available/default << EOF
server {
    listen 80;
    server_name 0.0.0.0;
    location / {
        proxy_pass http://127.0.0.1:4321;
        proxy_set_header Host \$host;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

# 初始化 p7s
python p7s_init.py
chmod -R 777 /usr/share/nginx/html
