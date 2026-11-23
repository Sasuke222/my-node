#!/bin/sh
set -e

export XRAY_LOCATION_ASSET=/usr/local/xray
PORT="${PORT:-8080}"
WS_PATH="${WS_PATH:-/ws}"

if [ -z "$UUID" ]; then
  UUID="$(cat /proc/sys/kernel/random/uuid)"
  echo "[node] UUID env not set, generated for this run: $UUID"
  echo "[node] Set the UUID environment variable in Komuta to keep it stable across restarts."
fi

mkdir -p /tmp/xray
cat > /tmp/xray/config.json <<EOF
{
  "log": { "loglevel": "warning" },
  "inbounds": [
    {
      "listen": "0.0.0.0",
      "port": ${PORT},
      "protocol": "vless",
      "settings": {
        "clients": [{ "id": "${UUID}", "level": 0 }],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": { "path": "${WS_PATH}" }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls", "quic"]
      }
    }
  ],
  "outbounds": [
    { "protocol": "freedom", "tag": "direct" },
    { "protocol": "blackhole", "tag": "block" }
  ],
  "routing": {
    "rules": [
      { "type": "field", "ip": ["geoip:private"], "outboundTag": "block" }
    ]
  }
}
EOF

echo "[node] starting xray on port ${PORT}, ws path ${WS_PATH}"
exec /usr/local/xray/xray run -config /tmp/xray/config.json
