require "tapclicks-api/version"
require "tapclicks-api/service"
require "tapclicks-api/model"
require "net/http"
require "uri"
require "json"

# Require services
Dir[File.join(File.dirname(__FILE__), 'tapclicks-api', 'service', '*.rb')].each { |file| require file }

module TapclicksApi
end
