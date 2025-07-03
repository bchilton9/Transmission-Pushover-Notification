# Pushover Notifications for Transmission in Docker (Linux)

This script sends a Pushover notification whenever a torrent finishes downloading in a Transmission container on a Linux system. It runs on the host and is triggered by Transmission's post-download hook using environment variables provided by the container.

## 📦 Features

- Sends notifications via [Pushover](https://pushover.net)
- Includes torrent name, save path, and hostname
- Runs on any Linux system with Docker
- Simple log output to `/var/log/pushover`

## 🛠️ Requirements

- Linux system running Transmission in Docker
- Pushover account with a registered application
- `curl` installed on the host system

## 🧾 Getting Your Pushover Token and User Key

1. **Create a Pushover account** at [https://pushover.net](https://pushover.net)
2. **Get your User Key** from the dashboard after logging in.
3. **Create a new application** at [https://pushover.net/apps/build](https://pushover.net/apps/build)
4. After creating your app, you’ll receive your **Application Token**.

## ✏️ Add Tokens to the Script

Open the script and locate these lines near the top:

```bash
PUSHOVER_TOKEN='TTTTTTTTTT'
PUSHOVER_USER_KEY='UUUUUUUUUU'
```

Replace them with your actual keys:

```bash
PUSHOVER_TOKEN='your-app-token-here'
PUSHOVER_USER_KEY='your-user-key-here'
```

## 📂 Installation

1. **Create the script on your host**

Save the following to a path like:

```
/opt/transmission_notify.sh
```

Make it executable:

```bash
chmod +x /opt/transmission_notify.sh
```

2. **Mount the script into the Transmission container**

If using `docker run`:

```bash
-v /opt:/scripts
```

Or with `docker-compose`:

```yaml
volumes:
  - /opt:/scripts
```

3. **Set Transmission environment variables**

Add the following to your container’s configuration:

```yaml
environment:
  - TRANSMISSION_SCRIPT_TORRENT_DONE_ENABLED=true
  - TRANSMISSION_SCRIPT_TORRENT_DONE_FILENAME=/scripts/transmission_notify.sh
```

## ✅ Test It

You can test the script manually like this:

```bash
TR_TORRENT_NAME="Test File" \
TR_TORRENT_DIR="/downloads" \
/opt/transmission_notify.sh
```

## 📜 License

MIT – free to use and modify. Not affiliated with Pushover or Transmission.

## 🛠 Made By

[ChilSoft.com](https://chilsoft.com) with caffeine and questionable commits.

## ⚠️ Disclaimer

This site and its contents are provided for informational and educational purposes only.

Use any code, tools, or instructions at your own risk.  
We are **not responsible** for any damage to your device, data loss, or unintended consequences.

Always proceed with care -- and make backups.

© **2025 ChilSoft**. All rights reserved.

