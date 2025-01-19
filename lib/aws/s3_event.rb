require 'cgi'

module ManagerClassifier
  module Aws
    class S3Event

      def initialize(aws_event)
        @aws_event = aws_event
      end

      def records
        @aws_event['Records'].collect do |aws_record|
          S3EventRecord.new(aws_record)
        end
      end

    end

    class S3EventRecord

      def initialize(record)
        @record = record
      end

      def s3
        @record['s3']
      end

      def object
        s3['object']
      end

      def key
        CGI.unescape(object['key'])
      end

    end
  end
end