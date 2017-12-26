RspecApiDocumentation.configure do |config|
  config.app = Rails.application

  # Output folder
  config.docs_dir = Rails.root.join("doc", "api")

  # An array of output format(s).
  # Possible values are :json, :html, :combined_text, :combined_json,
  #   :json_iodocs, :textile, :markdown, :append_json
  config.format = [:html]

  # Change the name of the API on index pages
  config.api_name = "API Test"

  # Change the description of the API on index pages
  config.api_explanation = "Sample API for Test"
end