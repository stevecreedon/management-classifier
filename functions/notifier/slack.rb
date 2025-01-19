require 'rexml'
require 'httparty'
require 'json'

module ManagerClassifier
  module Functions
    module Notifier
      class Slack
        include HTTParty

        base_uri ENV.fetch("SLACK_URI")

        def initialize(text)
          @text = text
        end

        def send
          self.class.post(ENV.fetch("SLACK_PATH"), body: { text: @text }.to_json, headers: headers)
        end

        def headers
          {
            'Content-Type' => 'application/json',
            'Accepts' => 'text/plain',
            'Authorization' => "Bearer #{token}"
          }
        end

        def token

        end
      end
    end
  end
end

def send_text(channel, text)
  data = { channel: channel, text: text }
  result = JSON.parse(Net::HTTP.post(uri, data.to_json , header).body)
  raise SlackFailure.new(result, data) unless result['ok']
end

def header
  {
    'Content-Type' => 'application/json',
    'Accepts' => 'text/plain',
    'Authorization' => "Bearer #{token}"
  }
end

def token
  ENV['SLACK_TOKEN']
end

def uri 
  URI("https://slack.com/api/chat.postMessage")
end