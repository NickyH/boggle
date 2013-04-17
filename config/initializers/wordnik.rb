Wordnik.configure do |config|
  config.api_key = ENV['WNIKKEY']              # required
  config.username = 'nickyh'                    # optional, but needed for user-related functions
  config.password = ENV['WNIKPAS']               # optional, but needed for user-related functions
  config.response_format = 'json'             # defaults to json, but xml is also supported
  config.logger = Logger.new('/dev/null')     # defaults to Rails.logger or Logger.new(STDOUT). Set to Logger.new('/dev/null') to disable logging.
end