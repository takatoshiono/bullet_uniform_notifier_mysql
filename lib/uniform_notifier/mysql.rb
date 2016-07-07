require 'uniform_notifier/base'
require 'mysql2'

class UniformNotifier
  class Mysql < Base
    @mysql2 = nil

    class << self
      def active?
        @mysql2
      end

      def setup_connection(config = {})
        @mysql2 = Mysql2::Client.new(config)
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
        statement = @mysql2.prepare('INSERT INTO bullet_notifications(url, title, body, created_at) VALUES(?, ?, ?, ?)')
        statement.execute(data[:url], data[:title], data[:body], Time.now)
      end

      private

      def create_table
        @mysql2.query('DROP TABLE IF EXISTS bullet_notifications')
        @mysql2.query(<<-"SQL")
          CREATE TABLE bullet_notifications (
            id      int not null auto_increment,
            url     varchar(255) not null default '',
            title   varchar(255) not null default '',
            body    text not null,
            created_at datetime not null,
            updated_at timestamp not null,
            primary key (id)
          )
        SQL
      end
    end
  end
end
