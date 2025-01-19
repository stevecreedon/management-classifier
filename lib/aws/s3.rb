require 'aws-sdk-s3'

module ManagerClassifier
  module Aws
    module S3

      def s3
        @s3 ||= ::Aws::S3::Client.new
      end

      def object(key)
        s3.get_object(bucket: bucket, key: key)
      end

      def read(key)
        object(key).body.read
      end

      def bucket
        ENV.fetch("BUCKET")
      end

    end
  end
end