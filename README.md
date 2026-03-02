Okay, I understand you'd like me to create a GitHub README.md based on the information you provided about Marzban.

Here's a draft of the README.md documentation:

```markdown
# 🚀 Marzban: Unified GUI Censorship Resistant Solution

[Burmese Description]
Marzban သည် Xray-core ကို အခြေခံထားပြီး VPN အသုံးပြုသူများကို စနစ်တကျ စီမံခန့်ခွဲနိုင်ရန် ဖန်တီးထားသည့် ခေတ်မီပြီး အားကောင်းသော Dashboard တစ်ခု ဖြစ်ပါသည်။ ဤ Repository သည် တစ်ဦးတစ်ယောက်ချင်းဖြစ်စေ၊ အဖွဲ့အစည်းလိုက်ဖြစ်စေ VPN Service ပေးလိုသူများအတွက် လွယ်ကူမြန်ဆန်သော Installation နှင့် Management ကို ပံ့ပိုးပေးပါသည်။

## English Description
Marzban is a modern and powerful Dashboard built on Xray-core, designed to systematically manage VPN users. This repository provides quick and easy installation and management for individuals or organizations looking to offer VPN services.

## Quick Setup

Follow these steps to quickly set up Marzban:

### 1. Update and Upgrade System
```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Install Marzban
```bash
sudo bash -c "$(curl -sL https://github.com/Gozargah/Marzban-scripts/raw/master/marzban.sh)" @ install
```

### 3. Install Certbot (for SSL)
```bash
sudo apt install certbot -y
```

### 4. Obtain SSL Certificate
Replace `vpn.yourdomain.com` with your actual domain.
```bash
sudo certbot certonly --standalone -d vpn.yourdomain.com
```

### 5. Configure Marzban Environment Variables
Edit the `.env` file to configure SSL certificate paths.
```bash
nano /opt/marzban/.env
```
Add or modify the following lines in the `.env` file:
```
UVICORN_HOST = "0.0.0.0"
UVICORN_PORT = 8000
UVICORN_SSL_CERTFILE = "/etc/letsencrypt/live/vpn.yourdomain.com/fullchain.pem"
UVICORN_SSL_KEYFILE = "/etc/letsencrypt/live/vpn.yourdomain.com/privkey.pem"
```

### 6. Set Permissions for Let's Encrypt Certificates
```bash
chmod -R 755 /etc/letsencrypt/live/
chmod -R 755 /etc/letsencrypt/archive/
```

### 7. Update Docker Compose Configuration
Edit the `docker-compose.yml` file to mount the Let's Encrypt volume.
```bash
nano /opt/marzban/docker-compose.yml
```
Under the `volumes` section, ensure `/etc/letsencrypt` is added:
```yaml
volumes:
  - /var/lib/marzban:/var/lib/marzban
  - /etc/letsencrypt:/etc/letsencrypt # <--- ADD THIS LINE
```

### 8. Create Marzban Admin User
```bash
marzban cli admin create --sudo
```

---

Let me know if you'd like any adjustments or further sections added, like usage instructions, features, or troubleshooting!
