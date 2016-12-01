require 'singleton'

module S3
  class Bucket
    include Singleton
    attr_reader :bucket, :region, :access_key_id, :secret_access_key, :bucket_name

    def initialize(name)
      @region = Rails.application.secrets.send("s3_#{name}_region")
      @access_key_id = Rails.application.secrets.send("s3_#{name}_access_key_id")
      @secret_access_key = Rails.application.secrets.send("s3_#{name}_secret_access_key")
      @bucket_name = Rails.application.secrets.send("s3_#{name}_bucket_name")
      s3 = AWS::S3.new(
        region: region,
        access_key_id: access_key_id,
        secret_access_key: secret_access_key
      )
      @bucket = s3.buckets[bucket_name]
    end
  end
end
