require 's3/pdf_bucket'
require 's3/general_bucket'

module S3
  module BucketManagerService
    def self.download_file(bucket_name, filename)
      s3_file = get_bucket(bucket_name).objects[filename]
      s3_file.read
    end

    def self.upload_document(bucket_name, raw_bytes, filename)
      s3_file = get_bucket(bucket_name).objects[filename]
      s3_file.write(raw_bytes)
    end

    # Default is 'application/octet-stream' as its default behaviour is to trigger a file download
    def self.get_download_link(bucket_name, filename, content_type = 'application/octet-stream')
      get_bucket(bucket_name).objects[filename]
                             .url_for(:get, response_content_type: content_type,
                                            response_content_disposition: 'Attachment').to_s
    end

    def self.file_exists?(bucket_name, filename)
      return false if Rails.env == 'test' || Rails.env == 'development'
      get_bucket(bucket_name).objects[filename].exists?
    end

    # Returns a JSON with the following attrs: base_url, AWSAccessKeyId, key, policy, signature
    # and Content-Type.
    # filename: name of the s3_object to be created. Must be a uniq key
    # seconds: expiration time of the URL in seconds (integer)
    # content_type: content-type of the file to upload
    def self.generate_upload_link(bucket_name, filename, seconds, content_type)
      bucket = get_bucket(bucket_name)
      presigned_post = bucket.presigned_post(
        key: filename,
        expires: seconds,
        content_type: content_type
      )
      { base_url: presigned_post.url.to_s }.merge(presigned_post.fields)
    end

    def self.get_bucket(bucket_name)
      "S3::#{bucket_name.camelize}Bucket".constantize.instance.bucket
    end
  end
end
