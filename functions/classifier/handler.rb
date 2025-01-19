require 'json'
require_relative 'runner'
require 'lib/aws/http_post_request'

module ManagerClassifier
  module Functions
    module Classifier

      def self.handle(event:, context:)
        text = ManagerClassifier::Aws::HttpPostRequest.new(event).json['text']
        
        {
          statusCode: 200,
          body: Runner.new(text).classify.to_json
        }
      end

    end
  end
end
