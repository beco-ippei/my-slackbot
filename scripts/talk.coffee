# talk
controller.hears ['ぬるぽ$'], AMBIENT, (bot, message) ->
  params =
    timestamp: message.ts,
    channel: message.channel,
    name: 'boom',

  bot.api.reactions.add params, (err, res) ->
    if err
      bot.botkit.log "Failed to add emoji reaction :(", err

  bot.reply message, "ガッ"

controller.hears ['ぬるぽん'], AMBIENT, (bot, message) ->
  bot.reply message, "ん？"

controller.hears ['元気[？?]'], MENTIONS, (bot, message) ->
  bot.reply message, "元気だけど"

controller.hears ['いえ[ぃい]'], AMBIENT, (bot, message) ->
  params =
    timestamp: message.ts,
    channel: message.channel,
    name: 'sparkle',

  bot.api.reactions.add params, (err, res) ->
    if err
      bot.botkit.log "Failed to add emoji reaction :(", err

  bot.api.users.info {user: message.user}, (err, res) ->
    bot.reply message, "@#{res.user.name} :mount_fuji:"

