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

  This feature is disabled by default, but you can enable it with the following command: `shortening <on/off>`. You can find ignored urls [here](https://github.com/PoVa/sapphire_bot/blob/master/data/ignored_urls.yml).

* Owner of the bot can send mass message to all servers by sending the bot a private message.

### Commands

Commands start with a prefix, which is `!` by default.

* General:
  * `help` shows a list of all the commands available.
  * `help <command>` displays help for a specific command.
  * `about` shows information about this bot.
  * `stats` displays bot statistics.
  * `ping` shows with respond time.
  * `invite` displays information about inviting this bot to your sever.
  * `leave` makes the bot leave this server (user needs to have kick members permission).
  * `avatar <url>` sets avatar of this bot (user needs to be owner of the bot).
  * `settings` displays current server settings.

* Fun:

  * `flip` fips a coin.
  * `roll` rolls a dice.
  * `lmgtfy <text> ` generates lmgtfy (Let Me Google That for you) link.

* Moderation:

  * `delete <ammount>` deletes messages in this channel (user needs to have manage messages permission).
  * `announce <message>` announces your message server-wide (user needs to have manage messages permission
  * `kickall` kicks all the members from the server, except you and the bot (user and the bot needs to have kick members permission).

* Configuration

  * `shortening <on/off>` enables or disables automatic link shortening server-wide (user needs to have manage server permission).

* Debugging

  * `eval <code>` evaluates Ruby expression(s) (user needs to be owner of the bot). **USE WITH EXTREME CAUTION**


### Support

You can find me (@PoVa, ID109268519115329536) on this server: https://discord.gg/0wXjGm76VHrlVadr.

### Upcoming features

* Web interface
* Voice features
* More per-server configuration

### Installing and running
Make sure you have `git` and `bundler` installed, then

   `$ git clone https://github.com/PoVa/sapphire_bot.git`

If you don't wish to contribute to this repositry, add `--without development` to the next command.

   `$ bundle install`

Run the bot.

   `$ ./sapphire_bot`

After you've done with configuration, invite url should pop up, use it to make the bot join your server.

### Updating

  `$ git pull`

### Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PoVa/sapphire_bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


### License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
