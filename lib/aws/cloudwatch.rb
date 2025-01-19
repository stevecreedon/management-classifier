require 'aws-sdk-cloudwatchlogs'

module ManagerClassifier
  module Aws
    module Cloudwatch

      def cloudwatch
        @cloudwatch ||= ::Aws::CloudWatchLogs::Client.new
      end

      def log_message(message)
        cloudwatch.put_log_events({
          log_group_name: ENV.fetch("LOG_GROUP_NAME"),
          log_stream_name: "app", # required
          log_events: [ # required
            {
              timestamp: timestamp, # required
              message: "#{self.class} - #{message}", # required
            },
          ],
        })
      end

      def log_error(error)
        cloudwatch.put_log_events({
          log_group_name: ENV.fetch("LOG_GROUP_NAME"),
          log_stream_name: "error", # required
          log_events: [ # required
            {
              timestamp: timestamp, # required
              message: "#{self.class} - #{error}", # required
            },
          ],
        })
      end

      def timestamp
        Time.new.strftime("%s%L")
      end

    end
  end
end