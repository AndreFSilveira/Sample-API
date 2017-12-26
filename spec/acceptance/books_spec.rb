require 'acceptance_helper'

resource 'Books' do
  before :all do
    @user = User.find_by_email('teste@test.com')
    if @user.nil?
      @user = FactoryGirl.create :user, email: 'teste@test.com', password: '123456'
    end
    19.times do
      FactoryGirl.create :book
    end
    @book  = FactoryGirl.create :book
  end



  describe 'Test Books' do
    header 'Host', 'api.lvh.me:3000'
    header 'Authorization', AuthenticateUser.call('teste@test.com', '123456').result
    header 'Content-Type', 'application/json'
    header 'Accept', 'application/json'

    get '/v1/books' do
      example 'Listing books' do
        do_request

        expect(status).to eq(200)
      end
    end

    get '/v1/books/:id' do
      let(:id) { @book.id }

      example 'Getting a specific book' do
        do_request

        expect(status).to eq(200)
      end
    end

    post '/v1/books' do
      parameter :name, 'Name of book', scope: :book
      parameter :pages, 'Pages of book', scope: :book
      parameter :leased, 'If book is leased', scope: :book
      parameter :year, 'year of book launch', scope: :book
      parameter :customer_id, 'Customer who rented the book', scope: :book

      response_field :name, 'Name of book', :scope => :book, 'Type' => 'String'
      response_field :pages, 'Pages of book', :scope => :book, 'Type' => 'Integer'
      response_field :leased, 'If book is leased', :scope => :book, 'Type' => 'Boolean'
      response_field :year, 'year of book launch', :scope => :book, 'Type' => 'Integer'
      response_field :customer_id, 'Customer who rented the book', :scope => :book, 'Type' => 'Customer'

      let(:name) { 'Book 1' }
      let(:pages) { 200 }
      let(:leased) { false }
      let(:year) { 2000 }
      let(:customer_id) { nil }

      let(:raw_post) { params.to_json }

      example_request 'Creating an book' do
        explanation 'First, create an book, then make a later request to get it back'

        book = JSON.parse(response_body)
        expect(book.except('id', 'created_at', 'updated_at')).to eq('name' => name,
                                                                    'pages' => pages,
                                                                    'leased' => leased,
                                                                    'year' => year,
                                                                    'customer_id' => customer_id)
        expect(status).to eq(201)

        client.get(URI.parse(response_headers['location']).path, {}, headers)
        expect(status).to eq(200)
      end
    end

    put "/v1/books/:id" do
      parameter :name, 'Name of book', scope: :book
      parameter :pages, 'Pages of book', scope: :book
      parameter :leased, 'If book is leased', scope: :book
      parameter :year, 'year of book launch', scope: :book
      parameter :customer_id, 'Customer who rented the book', scope: :book

      let(:id) { @book.id }
      let(:name) { "Updated Name" }

      let(:raw_post) { params.to_json }

      example_request "Updating an book" do
        expect(status).to eq(200)
      end
    end

    delete "/v1/books/:id" do
      let(:id) { @book.id }

      example_request "Deleting an book" do
        expect(status).to eq(204)
      end
    end

  end
end
