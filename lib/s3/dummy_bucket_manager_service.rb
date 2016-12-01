module S3
  module DummyBucketManagerService
    def self.download_file(bucket_name, filename)
      File.open("spec/fixtures/integrations/s3/#{bucket_name}/#{filename}", 'r') do |file|
        return file.read
      end
    end

    def self.upload_document(bucket_name, raw_bytes, file_url)
      FileUtils.mkdir_p("/tmp/#{bucket_name}/#{File.dirname(file_url)}")
      File.open("/tmp/#{bucket_name}/#{file_url}", 'wb') do |file|
        file.write(raw_bytes)
      end
    end

    def self.get_download_link(bucket_name, filename, _content_type = nil)
      "https://example.com/#{bucket_name}/#{filename}"
    end

    def self.file_exists?(bucket_name, filename)
      return false
    end

    # Returns a JSON with the following attrs: base_url, AWSAccessKeyId, key, policy, signature
    # and Content-Type.
    # filename: name of the s3_object to be created. Must be a uniq key
    # seconds: expiration time of the URL in seconds (integer)
    # content_type: content-type of the file to upload
    def self.generate_upload_link(bucket_name, filename, _seconds, content_type)
      {
        base_url: "http://example.com/#{bucket_name}/#{filename}",
        AWSAccessKeyId: 'aws_access_key_id',
        key: filename,
        policy: 'policy',
        signature: 'signature',
        content_type: content_type
      }
    end
  end
end
