require "bunny"
require "logger"
require "yaml"

class Publisher
	def initialize(rmq_uri, exchange)
		@connection = Bunny.new rmq_uri

		@connection.start
		@channel = @connection.create_channel

		@exchange = @channel.direct(exchange, durable: true)
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
		@logger = Logger.new(File.join(__dir__, "omrabbitmq.log"))
		@settings = YAML.load_file File.join(__dir__, "settings.yml")
		@logger.info "start"

		@pub = Publisher.new(@settings["rabbitmq_uri"], @settings["exchange"])
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

