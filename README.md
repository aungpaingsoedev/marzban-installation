# 🚀 Marzban Dashboard Installation ပြုလုပ်နည်း

## Quick Setup

Marzban ကို လျင်မြန်စွာ စတင်အသုံးပြုနိုင်ရန် အောက်ပါအဆင့်များကို ပြုလုပ်ပါ။

### ၁။ System Update ပြုလုပ်ခြင်း

```bash
sudo apt update && sudo apt upgrade -y
```

### ၂။ Marzban Install ခြင်း

```bash
sudo bash -c "$(curl -sL https://github.com/Gozargah/Marzban-scripts/raw/master/marzban.sh)" @ install
```

### ၃။ Certbot (SSL အတွက်) တပ်ဆင်ခြင်း

```bash
sudo apt install certbot -y
```

### ၄။ SSL လက်မှတ် ရယူခြင်း

သင့် VPN Server ၏ Domain Name (ဥပမာ: `vpn.yourdomain.com`) ကို အသုံးပြု၍ SSL လက်မှတ်ရယူပါ။ `vpn.yourdomain.com` နေရာတွင် သင့်ကိုယ်ပိုင် Domain Name ကို အစားထိုးထည့်သွင်းပါ။
```bash
sudo certbot certonly --standalone -d vpn.yourdomain.com
```

### ၅။ Marzban Environment Variables ချိန်ညှိခြင်း

SSL လက်မှတ်လမ်းကြောင်းများကို ချိန်ညှိရန်အတွက် `/opt/marzban/.env` ဖိုင်ကို ပြင်ဆင်ပါ။
```bash
nano /opt/marzban/.env
```
`.env` ဖိုင်အတွင်း အောက်ပါလိုင်းများကို ထည့်သွင်း (သို့မဟုတ်) ပြင်ဆင်ပါ။
```
UVICORN_HOST = "0.0.0.0"
UVICORN_PORT = 8000
UVICORN_SSL_CERTFILE = "/etc/letsencrypt/live/vpn.yourdomain.com/fullchain.pem"
UVICORN_SSL_KEYFILE = "/etc/letsencrypt/live/vpn.yourdomain.com/privkey.pem"
```

### ၆။ Let's Encrypt လက်မှတ်များအတွက် Permissions သတ်မှတ်ခြင်း

```bash
chmod -R 755 /etc/letsencrypt/live/
chmod -R 755 /etc/letsencrypt/archive/
```

### ၇။ Docker Compose Configuration အဆင့်မြှင့်တင်ခြင်း

Let's Encrypt volumes များကို ထည့်သွင်းရန်အတွက် `/opt/marzban/docker-compose.yml` ဖိုင်ကို ပြင်ဆင်ပါ။
```bash
nano /opt/marzban/docker-compose.yml
```
`volumes` အပိုင်းအောက်တွင် `/etc/letsencrypt` ကို အောက်ပါအတိုင်း ထည့်သွင်းထားကြောင်း သေချာပါစေ။
```yaml
volumes:
  - /var/lib/marzban:/var/lib/marzban
  - /etc/letsencrypt:/etc/letsencrypt # <--- ဤလိုင်းကို ထည့်သွင်းပါ
```

### ၈။ Marzban Admin Account ဖန်တီးခြင်း

Marzban Dashboard ကို စီမံခန့်ခွဲရန် လိုအပ်သော Admin User ကို ဖန်တီးပါ။ ဤ Command သည် အသုံးပြုသူအမည်နှင့် စကားဝှက်ကို မေးမြန်းပါလိမ့်မည်။
```bash
marzban cli admin create --sudo
```
