Airbrake.configure do |config|
  config.api_key = '1af0ab5f7a86bcee420b5dcecda47d04'
  config.host    = '122.112.89.151'
  config.port    = 3001
  config.secure  = config.port == 443
  config.development_environments = []
end