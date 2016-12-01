require 's3/bucket_manager_service'
require 's3/dummy_bucket_manager_service'

module S3
  module Service
    def self.get
      Rails.env.production? ? BucketManagerService : DummyBucketManagerService
    end
  end
end
