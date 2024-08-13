# Docker wrapper for the telegram-bot-api
## Sources
* [telegram-bot-api](https://github.com/tdlib/telegram-bot-api) - an intermittent bot api server between a bot and the telegram,
  allows to do several things that can't be done with a direct connection (see [using a local bot api server](https://core.telegram.org/bots/api#using-a-local-bot-api-server)).
* [alpine-linux](https://hub.docker.com/_/alpine/) - small size linux distribution based on musl as libc and busybox

## Configuration

Environment variables:
* API_ID 
* API_HASH

Directories and files:
* /telegram-bot-api/files here bot api stores downloaded files and other working data
* /telegram-bot-api/temp  here bot api stores temporary http files

## Examples

### Checking the api keys and tokens

Basic example to validate api_hash, api_id and bot_token.

```bash
# Run bot api in the background
docker run -d -e API_HASH=<api_hash> -e API_ID=<api_id> -p 8081:8081 lanseg/telegram-bot-api

# Run basic client
curl "http://localhost:8081/bot<YOUR_BOT_TOKEN>/getMe"
```

And if all the keys are correct, you should get something like this:
```json
{
    "ok": true,
    "result": {
        "id": 5133968151,
        "is_bot": true,
        "first_name": "chronist",
        "username": "chronist470529371_bot",
        "can_join_groups": true,
        "can_read_all_group_messages": true,
        "supports_inline_queries": false,
        "can_connect_to_business": false,
        "has_main_web_app": false
    }
}

```
