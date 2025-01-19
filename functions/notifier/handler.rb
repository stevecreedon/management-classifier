require 'lib/aws/s3_event'
require 'lib/aws/cloudwatch'
require_relative 'runner'

module ManagerClassifier
  module Functions
    module Notifier

      def self.handle(event:, context:)
        ManagerClassifier::Aws::S3Event.new(event).records.each do |record|
          Runner.new(record.key).run!
        end
      end

    end
  end
end