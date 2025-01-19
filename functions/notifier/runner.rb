require 'lib/aws/s3'
require_relative 'classifier'
require_relative 'slack'

module ManagerClassifier
  module Functions
    module Notifier
      class Runner
        include ManagerClassifier::Aws::S3
        include ManagerClassifier::Aws::Cloudwatch

        def initialize(key)
          @key = key
        end

        def run!
          log_message("reading #{@key}")
          log_message("posting #{text} to classifier #{ENV.fetch("CLASSIFIER_URI")}")
          log_message("posting #{message} to slack #{ENV.fetch("CLASSIFIER_URI")}")
          Slack.new(message).send
        end

        def message
          if classification['buzzwords'].count > 0
            "document #{@key} uploaded, found #{ classification['buzzwords'] } score of #{ classification['score'] }"
          else 
            "no buzzwords found in #{@key}...."
          end
        end

        def text
          @text ||= read(@key)
        end

        def classification
          @classification ||= Classifier.new(text).call
        end

      end
    end
  end
end