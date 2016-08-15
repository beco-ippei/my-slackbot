## get weather news from weather-underground
## TODO: make class and use 'module.exports'
#WEATHER_API = "http://api.wunderground.com/api"
#WEATHER_API_KEY = process.env.weather_api_key
#
## use 'Weather Underground' API
## fixed Japan/Kyoto
#getWeatherForcast = (place, callback) ->
#  url = "#{WEATHER_API}/#{WEATHER_API_KEY}/forecast/q/#{place}.json"
#  console.log "getWeatherForcast : '#{url}'"
#  request.get {url: url}, (err, r, body) ->
#    if err
#      console.dir err
#    else
#      callback(JSON.parse(body))
#
## wu-icons
#ICON_SUNNY = ':sunny:'
#ICON_P_SUNNY = ':partly_sunny:'
#ICON_P_RAIN = ':rain_cloud:'
#ICON_RAIN = ':umbrella:'
#ICON_CLOUD = ':cloud:'
#ICON_FOG = ':foggy:'
#ICON_SNOW = ':snowman:'
#ICON_STORM = ':zap::umbrella:'
#
#SUNNYS = ['clear', 'sunny', 'mostlysunny']   # ':sunny:'
#P_SUNNYS = ['mostlycloudy', 'partlycloudy']
#CLOUDS = ['cloudy']
#FOGS = ['fog', 'hazy']
#RAINS = ['rain', 'flurries']
#P_RAINS = ['chancerain']
#SNOWS = ['sleet', 'snow']
#STORMS = ['tstorms']
#
#weatherIcon = (name) ->
#  if name in SUNNYS
#    ICON_SUNNY
#  else if name in P_SUNNYS
#    ICON_P_SUNNY
#  else if name in CLOUDS
#    ICON_CLOUD
#  else if name in FOGS
#    ICON_FOG
#  else if name in RAINS
#    ICON_RAIN
#  else if name in P_RAINS
#    ICON_P_RAIN
#  else if name in SNOWS
#    ICON_SNOW
#  else if name in STORMS
#    ICON_STORM
#  else
#    name
#
#weatherReport = (cb) ->
#  try
#    getWeatherForcast 'Japan/Kyoto', (res) ->
#      w = res.forecast.simpleforecast.forecastday[1]
#      data = {
#        temp: {h: w.high.celsius, l: w.low.celsius},
#        cond: w['conditions'],
#        humidity: w['avehumidity'],
#        pop: w['pop']
#      }
#      cb "明日の天気は : #{weatherIcon w.icon} #{data.cond},  " +
#        "気温 H=#{data.temp.h}c / L=#{data.temp.l}c,  " +
#        "湿度 #{data.humidity}%,  降水確率 #{data.pop}%"
#  catch ex
#    console.dir ex

