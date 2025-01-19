require "base64"
require 'json'

module ManagerClassifier
  module Aws
    class HttpPostRequest

      def initialize(aws_event)
        @aws_event = aws_event
      end

      def raw
        @aws_event['body']
      end

      def json
        JSON.parse(@aws_event['body'])
      end
    end
  end
end