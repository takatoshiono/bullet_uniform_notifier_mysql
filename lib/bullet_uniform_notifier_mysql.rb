require "bullet_uniform_notifier_mysql/version"
require "uniform_notifier"
require 'uniform_notifier/mysql'
require 'bullet'

module BulletUniformNotifierMysql
  # Your code goes here...
end

class UniformNotifier
  class << self
    attr_accessor :mysql

    def active_notifiers
      [Mysql, *NOTIFIERS].select { |notifier| notifier.active? }
    end

    def mysql=(mysql)
      UniformNotifier::Mysql.setup_connection(mysql)
    end
  end
end

module Bullet
  class << self
    delegate :mysql=, to: UniformNotifier
  end
end
