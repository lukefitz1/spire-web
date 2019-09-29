# require "carrierwave/orm/activerecord"

# CarrierWave.configure do |config|
# 	config.storage    = :aws
# 	config.aws_bucket = ENV["S3_BUCKET"]
# 	config.aws_acl    = 'public-read'

# #   # Optionally define an asset host for configurations that are fronted by a
# #   # content host, such as CloudFront.
# #   # config.asset_host = 'http://example.com'

#   # The maximum period for authenticated_urls is only 7 days.
#   config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

#   # Set custom options such as cache control to leverage browser caching
#   config.aws_attributes = {
#     expires: 1.week.from_now.httpdate,
#     cache_control: 'max-age=604800'
#   }

#   config.aws_credentials = {
#     access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
#     secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
#     region:            ENV["AWS_REGION"] # Required
#   }

# #   # Optional: Signing of download urls, e.g. for serving private content through
# #   # CloudFront. Be sure you have the `cloudfront-signer` gem installed and
# #   # configured:
# #   # config.aws_signer = -> (unsigned_url, options) do
# #   #   Aws::CF::Signer.sign_url(unsigned_url, options)
# #   # end
# end

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",                        # required
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],                        # required unless using use_iam_profile
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],                        # required unless using use_iam_profile
    region: "us-east-2",                  # optional, defaults to 'us-east-1'
  # host: "s3.example.com",             # optional, defaults to nil
  # endpoint: "https://s3.example.com:8080", # optional, defaults to nil
  }
  config.fog_directory = ENV["S3_BUCKET"]                                      # required
  # config.fog_public = false                                                 # optional, defaults to true
  # config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end
