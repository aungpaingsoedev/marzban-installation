#!/bin/bash

# ၁။ Domain Name တောင်းခြင်း
read -p "Enter your Domain (e.g. vpn.example.com): " DOMAIN

# ၂။ System Update & Essential Tools
sudo apt update && sudo apt upgrade -y
sudo apt install -y certbot curl nano

# ၃။ SSL လက်မှတ်ရယူခြင်း
sudo certbot certonly --standalone -d $DOMAIN --agree-tos --register-unsafely-without-email

# ၄။ Marzban Core ကို Install လုပ်ခြင်း
sudo bash -c "$(curl -sL https://github.com/Gozargah/Marzban-scripts/raw/master/marzban.sh)" @ install

# ၅။ .env ဖိုင်ကို SSL အတွက် ပြင်ဆင်ခြင်း
ENV_FILE="/opt/marzban/.env"
sudo sed -i "s|^#\? \?UVICORN_SSL_CERTFILE =.*|UVICORN_SSL_CERTFILE = \"/etc/letsencrypt/live/$DOMAIN/fullchain.pem\"|" $ENV_FILE
sudo sed -i "s|^#\? \?UVICORN_SSL_KEYFILE =.*|UVICORN_SSL_KEYFILE = \"/etc/letsencrypt/live/$DOMAIN/privkey.pem\"|" $ENV_FILE

# ၆။ docker-compose.yml ထဲမှာ SSL Volume ထည့်ခြင်း
DOCKER_FILE="/opt/marzban/docker-compose.yml"
if ! grep -q "/etc/letsencrypt:/etc/letsencrypt" "$DOCKER_FILE"; then
    sudo sed -i '/- \/var\/lib\/marzban:\/var\/lib\/marzban/a \      - /etc/letsencrypt:/etc/letsencrypt' $DOCKER_FILE
fi

# ၇။ Permissions သတ်မှတ်ခြင်း
sudo chmod -R 755 /etc/letsencrypt/live/
sudo chmod -R 755 /etc/letsencrypt/archive/

# ၈။ Admin User ဖန်တီးခြင်း (Username/Password တောင်းပါလိမ့်မည်)
marzban cli admin create --sudo

# ၉။ Restart ချခြင်း
marzban restart

echo -e "\n✨ အားလုံးအဆင်ပြေသွားပါပြီ!"
echo -e "🔗 Dashboard Link: https://$DOMAIN:8000/dashboard"
