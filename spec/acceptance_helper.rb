require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = [:json, :combined_text, :html]
  config.curl_host = 'http://api.lvh.me:3000'
  config.api_name = "Test App API"
  config.api_explanation = "API Test Description"
end