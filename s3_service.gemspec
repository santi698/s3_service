Gem::Specification.new do |s|
  s.name        = 's3_service'
  s.version     = '0.1.0'
  s.date        = '2016-12-01'
  s.summary     = 'A service to help doing file related tasks on S3'
  s.description = 'A service to help doing file related tasks on S3'
  s.authors     = ['Santiago Ocamica']
  s.email       = 'santiago.ocamica@increasecard.com'
  s.files       = ['lib/s3_service.rb', 'lib/s3/bucket_manager_service.rb', 'lib/s3/dummy_bucket_manager_service.rb',
                   'lib/s3/bucket.rb', 'lib/s3/pdf_bucket.rb', 'lib/s3/general_bucket.rb', 'lib/s3/service.rb']
  s.homepage    = 'http://rubygems.org/gems/s3_service'
  s.add_runtime_dependency 'aws-sdk', ['< 2']
  s.license       = 'GPLv3'
end
