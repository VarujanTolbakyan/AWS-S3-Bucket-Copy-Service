class S3BucketCopyService
  def self.call(object_key)
    source_bucket_name = Rails.application.credentials.s3_temp_bucket!
    target_bucket_name = Rails.application.credentials.s3_storage_bucket!

    creds = Aws::Credentials.new(Rails.application.credentials.s3_access_key_id!,
                                 Rails.application.credentials.s3_secret_key!)
    s3 = Aws::S3::Client.new(region: Rails.application.credentials.s3_region!, credentials: creds)
    s3.copy_object(bucket: target_bucket_name, copy_source: "#{source_bucket_name}/#{object_key}", key: object_key)
  end
end

# Rails.application.credentials.s3_temp_bucket!            your S3 tempbucket name example: temp-development-test-storage
# Rails.application.credentials.s3_storage_bucket!         your S3 bucket name example: development-test-storage
# Rails.application.credentials.s3_access_key_id!          your AWS access key
# Rails.application.credentials.s3_secret_key!             your AWS secret key
# Rails.application.credentials.s3_region!                 your S3 bucket region example: eu-central-1
  
# in your Gemfile add   gem 'aws-sdk-s3'
