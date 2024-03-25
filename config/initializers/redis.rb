# frozen_string_literal: true

class RedisCurrent
  def self.connection
    @connection ||= RedisProxy.new(pool)
  end

  def self.pool
    ConnectionPool.new(size: ENV.fetch('REDIS_POOL').to_i, timeout: ENV.fetch('REDIS_TIMEOUT').to_i) do
      Redis.new(url: ENV.fetch('REDIS_URL'))
    end
  end
end

class RedisProxy
  def initialize(connection_pool)
    @connection_pool = connection_pool
  end

  private

  attr_reader :connection_pool

  def method_missing(name, *args, &block) # rubocop:disable Style/MissingRespondToMissing
    connection_pool.with do |redis|
      redis.send(name, *args, &block)
    end
  end
end
