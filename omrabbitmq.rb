require "bunny"
require "logger"

class Publisher
	def initialize
		# amqp://user:pass@host:port/vhost
		@connection = Bunny.new ENV["RSYSLOG_RMQ_URI"]

		@connection.start
		@channel = @connection.create_channel

		@exchange = @channel.direct("rsyslog", durable: true)
	end

	def publish(message)
		@exchange.publish(message, persistent: true)
	end

	def disconnect
		@connection.close
	end
end

class RabbitMQLogger
	def initialize
		@logger = Logger.new("omrabbitmq.log")
		@logger.info "start"

		@pub = Publisher.new
	end

	def read
		while true
			break if $stdin.eof?
			message = $stdin.gets
			@logger.info message
			@pub.publish(message)
		end
	end

	def close
		@logger.info "exit"
		@pub.disconnect
	end
end

rmq_logger = RabbitMQLogger.new
rmq_logger.read
rmq_logger.close

