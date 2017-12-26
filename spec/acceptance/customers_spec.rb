require 'acceptance_helper'

resource 'Customers' do
  before :all do
    @user = User.find_by_email('teste@test.com')
    if @user.nil?
      @user = FactoryGirl.create :user, email: 'teste@test.com', password: '123456'
    end
    19.times do
      FactoryGirl.create :customer
    end
    @customer  = FactoryGirl.create :customer
  end



  describe 'Test Customer' do
    header 'Host', 'api.lvh.me:3000'
    header 'Authorization', AuthenticateUser.call('teste@test.com', '123456').result
    header 'Content-Type', 'application/json'
    header 'Accept', 'application/json'

    get '/v1/customers' do
      example 'Listing customers' do
        do_request

        expect(status).to eq(200)
      end
    end

    get '/v1/customers/:id' do
      let(:id) { @customer.id }

      example 'Getting a specific customer' do
        do_request

        expect(status).to eq(200)
      end
    end

    post '/v1/customers' do
      parameter :name, 'Name of customer', scope: :customer
      parameter :email, 'Email of customer', scope: :customer
      parameter :book, 'book leased', scope: :customer

      response_field :name, 'Name of cusomer', :scope => :customer, 'Type' => 'String'
      response_field :email, 'Email of customer', :scope => :customer, 'Type' => 'String'
      response_field :book, 'book leased', :scope => :customer, 'Type' => 'Book'

      let(:name) { 'Book 1' }
      let(:email) { Faker::Internet.free_email }

      let(:raw_post) { params.to_json }

      example_request 'Creating an customer' do
        explanation 'First, create an customer, then make a later request to get it back'

        book = JSON.parse(response_body)
        expect(book.except('id', 'created_at', 'updated_at')).to eq('name' => name,
                                                                    'email' => email)
        expect(status).to eq(201)

        client.get(URI.parse(response_headers['location']).path, {}, headers)
        expect(status).to eq(200)
      end
    end

    put "/v1/customers/:id" do
      parameter :name, 'Name of customer', scope: :customer
      parameter :email, 'Email of customer', scope: :customer
      parameter :book, 'book leased', scope: :customer

      let(:id) { @customer.id }
      let(:name) { "Updated Name" }

      let(:raw_post) { params.to_json }

      example_request "Updating an customer" do
        expect(status).to eq(200)
      end
    end

    delete "/v1/customers/:id" do
      let(:id) { @customer.id }

      example_request "Deleting an customer" do
        expect(status).to eq(204)
      end
    end

  end
end
