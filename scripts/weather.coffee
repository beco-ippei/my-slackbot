# get weather news from weather-underground
# TODO: make class in './lib' and use 'module.exports'
WEATHER_API = "http://api.wunderground.com/api"
WEATHER_API_KEY = process.env.weather_api_key

# use 'Weather Underground' API
# place like 'Japan/Kyoto'
getHourlyWeather = (place, callback) ->
  url = "#{WEATHER_API}/#{WEATHER_API_KEY}/hourly/q/#{place}.json"
  console.log "getWeatherForcast : '#{url}'"
  request.get {url: url}, (err, r, body) ->
    if err
      console.dir err
    else
      callback(JSON.parse(body))

# use 'Weather Underground' API
# place like 'Japan/Kyoto'
getWeatherForcast = (place, callback) ->
  url = "#{WEATHER_API}/#{WEATHER_API_KEY}/forecast/q/#{place}.json"
  console.log "getWeatherForcast : '#{url}'"
  request.get {url: url}, (err, r, body) ->
    if err
      console.dir err
    else
      callback(JSON.parse(body))

# wu-icons
ICON_SUNNY = ':sunny:'
ICON_P_SUNNY = ':partly_sunny:'
ICON_P_RAIN = ':rain_cloud:'
ICON_RAIN = ':umbrella:'
ICON_CLOUD = ':cloud:'
ICON_FOG = ':foggy:'
ICON_SNOW = ':snowman:'
ICON_STORM = ':zap::umbrella:'

SUNNYS = ['clear', 'sunny', 'mostlysunny']   # ':sunny:'
P_SUNNYS = ['mostlycloudy', 'partlycloudy']
CLOUDS = ['cloudy']
FOGS = ['fog', 'hazy']
RAINS = ['rain', 'flurries']
P_RAINS = ['chancerain']
SNOWS = ['sleet', 'snow']
STORMS = ['tstorms']

weatherIcon = (name) ->
  if name in SUNNYS
    ICON_SUNNY
  else if name in P_SUNNYS
    ICON_P_SUNNY
  else if name in CLOUDS
    ICON_CLOUD
  else if name in FOGS
    ICON_FOG
  else if name in RAINS
    ICON_RAIN
  else if name in P_RAINS
    ICON_P_RAIN
  else if name in SNOWS
    ICON_SNOW
  else if name in STORMS
    ICON_STORM
  else
    name

weatherReport = (cb) ->
  try
    getWeatherForcast 'Japan/Kyoto', (res) ->
      w = res.forecast.simpleforecast.forecastday[1]
      data = {
        temp: {h: w.high.celsius, l: w.low.celsius},
        cond: w['conditions'],
        humidity: w['avehumidity'],
        pop: w['pop']
      }
      cb "明日の天気は : #{weatherIcon w.icon} #{data.cond},  " +
        "気温 H=#{data.temp.h}c / L=#{data.temp.l}c,  " +
        "湿度 #{data.humidity}%,  降水確率 #{data.pop}%"
  catch ex
    console.dir ex

hourlyWeather = (cb) ->
  try
    getHourlyWeather 'Japan/Kyoto', (res) ->
      limit = new Date().getTime() + (24*60*60*1000)
      startHour = res.hourly_forecast[0]['FCTTIME'].hour
      weathers = []
      for w in res.hourly_forecast
        spentHours = w['FCTTIME'].hour - startHour
        time = new Date(w['FCTTIME'].epoch * 1000)
        if spentHours % 3 == 0 && time.getTime() < limit
          data = {
            temp: w.temp.metric,
            cond: w.condition,
            pop: w.pop,
            icon: weatherIcon(w.icon),
            time: time,
          }
          weathers.push formatWeather(data)
      cb "今日の天気は... \n" + weathers.join("\n")
  catch ex
    console.dir ex

formatWeather = (w) ->
  msg = []
  if w.time.getHours() == 0
    msg.push "#{w.time.getMonth()+1}/#{w.time.getDate()} (#{dayOfWeek w.time})\n"
  msg.push w.time.getHours()
  msg.push w.icon
  msg.push "#{w.temp}℃  / #{w.pop}%"
  msg.join " "

DAYS_OF_WEEK = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
dayOfWeek = (date) ->
  DAYS_OF_WEEK[date.getDay()]

# weather news
controller.hears ['明日の天気'], MENTIONS, (bot, message) ->
  weatherReport (report) ->
    bot.reply message, report

controller.hears ['今日の天気'], MENTIONS, (bot, message) ->
  hourlyWeather (report) ->
    bot.reply message, report

