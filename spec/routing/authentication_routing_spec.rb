RSpec.describe API::V1::AuthenticationController, type: :routing do
  describe 'authentication routing' do
    it 'routes to v1/authenticate to authentication#authenticate' do
      expect(:post => api_v1_authenticate_url).to route_to('api/v1/authentication#authenticate', subdomain: 'api')
    end
  end
end