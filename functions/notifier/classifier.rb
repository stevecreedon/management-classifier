require 'rexml'
require 'httparty'
require 'json'
require 'lib/aws/cloudwatch'

module ManagerClassifier
  module Functions
    module Notifier
      class Classifier
        include HTTParty
        include ManagerClassifier::Aws::Cloudwatch

        base_uri ENV.fetch("CLASSIFIER_URI")

        def initialize(text)
          @text = text
        end

        def call
          log_message("calling classifier function")
          response = self.class.post(classifier_path, body: { text: @text }.to_json, headers: headers)
          JSON.parse(response.body)
        end

        def classifier_path 
          ENV.fetch("CLASSIFIER_PATH")
        end

        def headers
          { 'Content-Type' => 'application/json' }
        end
      end
    end
  end
end