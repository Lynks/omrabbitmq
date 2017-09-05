# omrabbitmq
RabbitMQ output plugin for rsyslog v8

## Quick start
### Setup
Create a `settings.yml` file in the same directory as the `omrabbitmq.rb` file. See `settings.yml.sample` as an example.
See http://rubybunny.info/articles/connecting.html#using_connection_strings on formatting the connection string to your RabbitMQ instance
### Using with rsyslog
Create a `.config` file in `/etc/rsyslog.d/` with the following:
```
module(load="omprog")

action(type="omprog"
	binary="ruby omrabbitmq.rb"
	template="RSYSLOG_TraditionalFileFormat")
```
### Standalone
```
gem install bunny
ruby omrabbitmq.rb
```
`ctrl+D` to stop accepting messages
