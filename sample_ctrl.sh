#!/bin/sh
cd `dirname $0`

stop_process() {
  echo "stop bot process"
  kill `pgrep -f 'node\ bot.js\ --xx-name=vivot'`
}

if [ "${1}" = "stop" ]; then
  stop_process
  exit $?
elif [ "${1}" = "reboot" ]; then
  stop_process
fi

export token="xxxxxxxxxxxxxxx"
export weather_api_key="xxxxxxxxxxxxxx"
export DOCOMO_API_KEY="xxxxxxxxxxxxxxxxxxxx"

echo "starting bot process"
node bot.js --xx-name=vivot 1>>./logs/bot.log 2>>./logs/error.log &

