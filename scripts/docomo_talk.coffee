# talk with docomo-api implements at bottom (last match)

DOCOMO_API_KEY = process.env.DOCOMO_API_KEY

DocomoAPI = require('docomo-api')
api = new DocomoAPI(DOCOMO_API_KEY)

# delayed response queue
controller.delayed_hears ['.*'], MENTIONS, (bot, message) ->
  if !DOCOMO_API_KEY
    console.log "DOCOMO_API_KEY is missing"
    return

  msg = message.text
  console.log "docomo-talk: #{msg}"
  return if shutup || !msg

  bot.api.users.info {user: message.user}, (err, res) ->
    nickname = res.user.name

    talk msg, nickname, message.channel, (res) ->
      bot.reply message, res


KEY_DOCOMO_CONTEXT = 'docomo-talk-context-katos'
KEY_DOCOMO_CONTEXT_TTL = 'docomo-talk-context-katos-ttl'
TTL_MINUTES = 20
talk_status =
  context_key: {},
  context_ttl: {},

talk = (msg, nickname, channel, cb) ->
  context_key = "#{KEY_DOCOMO_CONTEXT}-#{channel}"
  ctx = talk_status.context_key[context_key] || ''

  last_talk = talk_status.context_ttl[KEY_DOCOMO_CONTEXT_TTL] || 0
  if !last_talk || minutesElapsed(last_talk, TTL_MINUTES)
    ctx = ''    # init ctx if time elapsed from prev talk api call

  opts =
    nickname: nickname,
    context: ctx,

  try
    api.createDialogue msg, opts, (err, data) ->
      unless err
        # save context
        talk_status.context_key[context_key] = data.context
        # save context time-to-live
        talk_status.context_ttl[KEY_DOCOMO_CONTEXT_TTL] = new Date().getTime()

        cb data.utt
      else
        console.dir err
        cb ":ghost: talk failed"

  catch ex
    console.dir ex

minutesElapsed = (from, minutes)->
  diff = new Date().getTime() - new Date(from).getTime()
  return parseInt(diff / (60 * 1000), 10) > minutes

String.prototype.repeat = (num) ->
  new Array(num + 1).join(this)

