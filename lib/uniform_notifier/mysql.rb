require 'uniform_notifier/base'
require 'mysql2'

class UniformNotifier
  class Mysql < Base
    @config = nil

    class << self
      def active?
        @config && mysql_client
      end

      def setup_connection(config = {})
        @config = config
        create_table
      end

      protected

      # Bullet calls `out_of_channel_notify` with following parameter.
      # {
      #   :user => whoami,
      #   :url => url,
      #   :title => title,
      #   :body => body_with_caller,
      # }
      def _out_of_channel_notify(data)
        statement = mysql_client.prepare('INSERT INTO bullet_notifications(url, title, body, created_at) VALUES(?, ?, ?, ?)')
        statement.execute(data[:url], data[:title], data[:body], Time.now)
      end

      private

      def mysql_client
        @mysql2 ||= Mysql2::Client.new(@config)
      end

      def create_table
        mysql_client.query('DROP TABLE IF EXISTS bullet_notifications')
        mysql_client.query(<<-"SQL")
          CREATE TABLE bullet_notifications (
            id      int not null auto_increment,
            url     varchar(255),
            title   varchar(255),
            body    text,
            created_at datetime,
            updated_at timestamp,
            primary key (id)
          )
        SQL
      end
    end
  end
end
