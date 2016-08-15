/*
 * copy from 'node_modules/botkit/bot.js'
 * Read all about it here:
 *   -> http://howdy.ai/botkit
 */

var Botkit = require('botkit/lib/Botkit.js')
request = require('request');
coffee = require('coffee-script');
require('coffee-script/register');

controller = Botkit.slackbot({
  debug: false,
});

bot = controller.spawn(
  {
    token:process.env.token
  }
).startRTM();

MENTIONS = 'direct_message,direct_mention,mention';
AMBIENT = 'ambient';
ALL = 'message_received';

shutup = false;

// define delay loader
controller.delayed_responses = [];
controller.delayed_hears = function(patterns, types, proc) {
  controller.delayed_responses.push([patterns, types, proc]);
};

// file is included here:
var fs = require('fs');

var files = fs.readdirSync('lib');
for (i in files) {
  require("./lib/" + files[i]);
}

var files = fs.readdirSync('scripts');
for (i in files) {
  require("./scripts/" + files[i]);
}

for (i in controller.delayed_responses) {
  var r = controller.delayed_responses[i];
  controller.hears(r[0], r[1], r[2]);
}

