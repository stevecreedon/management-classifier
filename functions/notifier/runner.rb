require 'lib/aws/s3'
require 'lib/aws/cloudwatch'
require_relative 'classifier'
require_relative 'slack'

module ManagerClassifier
  module Functions
    module Notifier
      class Runner
        include ManagerClassifier::Aws::S3
        include ManagerClassifier::Aws::Cloudwatch

        def initialize(key)
          log_message("document #{key}  uploaded")
          @key = key
        end

        def run!
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
          log_message("reading #{@key}")
          @text ||= read(@key)
        end

        def classification
          log_message("posting #{text} to classifier #{ENV.fetch("CLASSIFIER_URI")}")
          @classification ||= Classifier.new(text).call
        end

      end
    end
  end
end