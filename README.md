# omrabbitmq
RabbitMQ output plugin for rsyslog v8

## Quick start
### Using with rsyslog
Create a `.config` file in `/etc/rsyslog.d/` with the following:
```
module(load="omprog")

action(type="omprog"
	binary="ruby omrabbitmq.rb"
	template="RSYSLOG_TraditionalFileFormat")
```
be sure to set the environment variable `RSYSLOG_RMQ_URI` with the [connection string](http://rubybunny.info/articles/connecting.html#using_connection_strings) for your RabbitMQ instance
### Standalone
```
gem install bunny
RSYSLOG_RMQ_URI='amqp://user:pass@host:port/vhost' ruby omrabbitmq.rb
```
`ctrl+D` to stop accepting messages
