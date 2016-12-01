require 's3/bucket'

module S3
  class PdfBucket < Bucket
    def initialize
      super('pdf')
    end
  end
end
