require 'yaml'

module ManagerClassifier
  module Functions
    module Classifier

      class Runner

        def initialize(text)
          @text = text.downcase
        end

        def classify
          { buzzwords: matches, score: score }
        end

        def score
          match_words_count.to_f / text_count.to_f 
        end

        def buzzwords
          @buzzwords ||= YAML.load_file("functions/classifier/buzzwords.yml")[:words]
        end

        def match_words_count
          matches.join(" ").split(" ").count
        end

        def text_count
          @text.split(" ").count
        end

        def matches
          @matches ||= buzzwords.select do |buzzword|
            @text.include?(buzzword)
          end
        end

      end
    end
  end
end