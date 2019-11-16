#!/bin/bash

wget https://github.com/DamageControlStudio/Downloads/raw/master/p7s.zip
unzip -q p7s.zip


rm p7s.zip
rm p7s_local.py
rm p7s_sqlite.db
rm README.md
rm -rf __MAXOSX
rm explore.ipynb

rm /usr/share/nginx/html/p7s_sqlite.db
rm -rf /usr/share/nginx/html/files
rm -rf /usr/share/nginx/html/p7s_env

apt-get update
apt-get install nginx python-virtualenv ffmpeg

mkdir /usr/share/nginx/html/templates
mkdir /usr/share/nginx/html/files
mkdir /usr/share/nginx/html/logs

mv p7s_setup.py /usr/share/nginx/html/p7s_setup.py
mv p7s_main.py /usr/share/nginx/html/p7s_main.py
mv p7s_download.py /usr/share/nginx/html/p7s_download.py
mv p7s_utils.py /usr/share/nginx/html/p7s_utils.py
mv p7s_startup.sh /usr/share/nginx/html/p7s_startup.sh
mv templates/status.html /usr/share/nginx/html/templates/status.html
mv templates/welcome.html /usr/share/nginx/html/templates/welcome.html

cd /usr/share/nginx/html
virtualenv --no-site-packages p7s_env --python=python3
source p7s_env/bin/activate

pip install -U gunicorn flask youtube-dl

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

chmod -R 777 /usr/share/nginx/html

python p7s_setup.py

