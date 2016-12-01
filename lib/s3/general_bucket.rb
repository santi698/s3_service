require 's3/bucket'

module S3
  class GeneralBucket < Bucket
    def initialize
      super('general')
    end
  end
end
