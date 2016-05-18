## Sapphire
[![Travis](https://img.shields.io/travis/PoVa/sapphire_bot.svg?maxAge=2592000)](https://travis-ci.org/PoVa/sapphire_bot)
[![Join Discord](https://img.shields.io/badge/discord-join-7289DA.svg)](https://discord.gg/0wXjGm76VHrlVadr)
[![Bot invite](https://img.shields.io/badge/bot-invite-333399.svg)](https://discordapp.com/oauth2/authorize?&client_id=169055390552686592&scope=bot&permissions=66321471)

A simple bot for discord made with [discordrb](https://github.com/meew0/discordrb). The bot is under active development, I'm adding new features and fixing issues everyday. If you don't want to tinker around with code or host the bot on your own, you can invite it to your server by pressing the invite badge above. However, if you do, there are some *poorly written* instructions down [below](https://github.com/PoVa/sapphire_bot#installation).

### Features

* Automatic link shortening with https://goo.gl/. Whenever a link within a message is detected, the message gets replaced and all its links shortened. Example:

  `PoVa: look at his dank maymay m8: http://img.ifcdn.com/images/a52e08ff36a62190f8259a6b5e9aa2f9f9a86bb841bc6b01aa6cbacc7bbe846f_1.jpg`

  (Original message deleted)

  `Sapphire: PoVa: look at his dank maymay m8: http://goo.gl/U7GO0D`

  This feature is disabled by default, but you can enable it with the following command: `toggle shortening`. You can find ignored urls [here](https://github.com/PoVa/sapphire_bot/blob/master/data/ignored_urls.yml).

* Owner of the bot can send mass message to all servers by sending the bot a private message.

### Commands

Commands start with a prefix, which is `!` by default.

* General:
  * `help` shows a list of all the commands available.
  * `help <command>` displays help for a specific command.
  * `about` shows information about this bot.
  * `stats` displays bot statistics.
  * `ping` shows with respond time.
  * `invite` displays information about inviting this bot to your server.
  * `yt <query>` finds youtube video.
  * `settings` displays current server settings.

* Fun:

  * `flip` fips a coin.
  * `roll` rolls a dice.
  * `lmgtfy <text> ` generates lmgtfy (Let Me Google That for you) link.

* Music bot (manage_server permission needed for some commands):

  * `music_help` displays information on how to use music features.
  * `join` makes the bot join your voice channel (manage_server).
  * `leave` makes the bot leave your voice channel (manage_server).
  * `add <query>` adds a song to server queue and starts playing it.
  * `skip` skips current song (manage_server).
  * `queue` shows current queue.
  * `clearqueue <index/all>` deletes songs from server queue  (manage_server).

* Moderation (different permissions needed):

  * `delete <ammount>` deletes messages in this channel (manage messages).
  * `announce <message>` announces your message server-wide (manage messages).
  * `kickall` kicks all the members from the server, except you and the bot (kick members).

* Configuration (user needs to have manage server permission to use these)

  * `toggle <setting>` allows you to toggle different bot settings.
  * `set <setting> <value>` allows you to set values of different bot settings.
  * `default <setting/all>` resets bot setting (or all settings) to default.

* Debugging and owner only commands:

  * `eval <code>` evaluates Ruby expression(s). **USE WITH EXTREME CAUTION**
  * `avatar <url>` sets avatar of this bot.
  * `game <text>` sets game status of the bot.


### Support

You can find me (@PoVa, ID109268519115329536) on this server: https://discord.gg/0wXjGm76VHrlVadr.

### Upcoming features

* Web interface

### Installing and running
1. Make sure you have `git` and `bundler` installed, then

   `$ git clone https://github.com/PoVa/sapphire_bot.git`

3. (optional) Install voice [dependencies](https://github.com/meew0/discordrb#voice-dependencies). This is how I do it on my linux machine:

  `sudo apt-get install libsodium-dev`

  `sudo apt-get install libopus-dev`

  `sudo apt-get install libav-tools`

4. (optional) Remove `music` from command in the following step.

5. Run `bundle install`

  `$ bundle install --without development music`

4. Run the bot.

   `$ ./sapphire_bot`

After you've done with configuration, invite url should pop up, use it to make the bot join your server.

### Updating

  `$ git pull`

### Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PoVa/sapphire_bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


### License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
