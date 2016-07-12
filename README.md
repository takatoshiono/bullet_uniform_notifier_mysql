# BulletUniformNotifierMysql

The [Bullet](https://github.com/flyerhzm/bullet) gem is great to help you detect N+1 queries. The notifier of Bullet use [uniform_notifier](https://github.com/flyerhzm/uniform_notifier) gem.

BulletUniformNotifierMysql save notifications to MySQL.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bullet_uniform_notifier_mysql'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bullet_uniform_notifier_mysql

## Usage

Gemfile:

```
gem 'bullet'
gem 'bullet_uniform_notifier_mysql'
```

config/environments/test.rb:

```ruby
config.after_initialize do
  Bullet.enable = true
  Bullet.mysql = { host: 'localhost', username: 'root', database: 'test' }
end
```

Run your test code and bullet notifications will be saved to the MySQL `bullet_notifications` table.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/takatoshiono/bullet_uniform_notifier_mysql.

