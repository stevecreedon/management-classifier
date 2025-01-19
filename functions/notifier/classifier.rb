require 'rexml'
require 'httparty'
require 'json'

module ManagerClassifier
  module Functions
    module Notifier
      class Classifier
        include HTTParty

        base_uri ENV.fetch("CLASSIFIER_URI")

        def initialize(text)
          @text = text
        end

        def call
          response = self.class.post(ENV.fetch("CLASSIFIER_PATH"), body: { text: @text }.to_json, headers: headers)
          JSON.parse(response.body)
        end

        def headers
          { 'Content-Type' => 'application/json' }
        end
      end
    end
  end
end