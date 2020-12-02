#!/bin/bash

VER="v4.33.0"
UUID="b399821d-46e3-420c-a362-184657466eb3"
DOWNLOAD_LINK="https://github.com/v2fly/v2ray-core/releases/download/${VER}/v2ray-linux-64.zip"

# Install V2Ray binary to /usr/bin/v2ray
mkdir -p /tmp/v2ray
mkdir -p /usr/bin/v2ray
mkdir -p /usr/local/etc/v2ray
curl -L -o "/tmp/v2ray/v2ray.zip" ${DOWNLOAD_LINK}
unzip "/tmp/v2ray/v2ray.zip" -d "/usr/bin/v2ray/"

# config v2ray
install -d /usr/local/etc/v2ray
cat << EOF > /usr/local/etc/v2ray/config.json
{
  "inbounds": [
    {
      "port": 9050,
      "tag": "VLESS-in",
      "protocol": "VLESS",
      "settings": {
        "clients": [
          {
            "id": "$UUID",
            "alterId": 0
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
	"security": "auto",
        "wsSettings": {
          "path": "/"
      }
    }
  }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF

# start v2ray
chmod +x "/usr/bin/v2ray/v2ray"
/usr/bin/v2ray/v2ray -config /usr/local/etc/v2ray/config.json
