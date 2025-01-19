require 'rexml'
require 'httparty'
require 'json'
require 'lib/aws/cloudwatch'

module ManagerClassifier
  module Functions
    module Notifier
      class Slack
        include HTTParty
        include ManagerClassifier::Aws::Cloudwatch

        base_uri ENV.fetch("SLACK_URI")

        def initialize(text)
          @text = text
        end

        def send
          log_message("sending slack message")
          self.class.post(slack_path, body: { text: @text }.to_json)
        end

        def slack_path 
          ENV.fetch("SLACK_PATH")
        end

      end
    end
  end
end