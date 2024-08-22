#/bin/sh
set -euo pipefail

/telegram-bot-api/telegram-bot-api \
    --api-id $API_ID \
    --api-hash $API_HASH \
    --dir /telegram-bot-api/files \
    --temp-dir /telegram-bot-api/temp \
    --http-port=$HTTP_PORT \
    --local
