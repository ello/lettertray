<img src="http://d324imu86q1bqn.cloudfront.net/uploads/user/avatar/641/large_Ello.1000x1000.png" width="200px" height="200px" />

# Lettertray
[![Build Status](https://travis-ci.org/ello/lettertray.png)](https://travis-ci.org/ello/lettertray)

A self-hosted disposable e-mail service (think Mailinator) making use of the Sendgrid Parse API (and others via Griddler)

# Background

When running end-to-end or integration tests, we've found that it's sometimes
necessary to send live e-mail and be able to pick it up programmatically. There
are a lot of disposable e-mail services out there, but relatively few have APIs
you can use to pick up your mail programmatically.
[Mailinator](http://mailinator.com) does have an API, but it's strange to work
with and somewhat unreliable.

Lettertray gives you a similar service, but lets you host it yourself.

## Requirements
- Ruby 2.3 (or newer)
- Rails 4.1
- A Redis instance (incoming e-mails are stored in Redis temporarily, then
  expired every 5 minutes)

## Installation (for Heroku)
- Clone this repo locally: `git clone git@github.com:ello/lettertray.git`
- Set up a new Heroku app and push to it: `heroku create <my-lettertray-instance> && git push heroku master`
- Configure a secret key for the app: `heroku config:set SECRET_KEY_BASE=\`rake secret\``
- Configure the Sendgrid starter addon: `heroku addons:add sendgrid`
- Configure an inbound parse API redirect in the Sendgrid addon settings. You'll
  need to customize your MX records as well, but the URL will be
  `https://your-heroku-app.herokuapp.com/email_processor`
- Add a Redis addon to your Heroku app (many are available, any of them should
  work)
- Send e-mails, retrieve from the API at 
  `https://your-heroku-app.herokuapp.com/messages.json?email=<address>`

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/ello/lettertray.

## License
Lettertray is released under the [MIT License](/LICENSE.txt)

## Code of Conduct
Ello was created by idealists who believe that the essential nature of all human beings is to be kind, considerate, helpful, intelligent, responsible, and respectful of others. To that end, we will be enforcing [the Ello rules](https://ello.co/wtf/policies/rules/) within all of our open source projects. If you don’t follow the rules, you risk being ignored, banned, or reported for abuse.
