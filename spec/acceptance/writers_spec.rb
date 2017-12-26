require 'acceptance_helper'

resource 'Writers' do
  before :all do
    @user = User.find_by_email('teste@test.com')
    if @user.nil?
      @user = FactoryGirl.create :user, email: 'teste@test.com', password: '123456'
    end
    19.times do
      FactoryGirl.create :writer
    end
    @writer = FactoryGirl.create :writer
  end



  describe 'Test Writer' do
    header 'Host', 'api.lvh.me:3000'
    header 'Authorization', AuthenticateUser.call('teste@test.com', '123456').result
    header 'Content-Type', 'application/json'
    header 'Accept', 'application/json'

    get '/v1/writers' do
      example 'Listing writers' do
        do_request

        expect(status).to eq(200)
      end
    end

    get '/v1/writers/:id' do
      let(:id) { @writer.id }

      example 'Getting a specific writer' do
        do_request

        expect(status).to eq(200)
      end
    end

    post '/v1/writers' do
      parameter :name, 'Name of Writer', scope: :writer
      parameter :city, 'Writing hometown', scope: :writer
      parameter :dob, "writer's birth date", scope: :writer
      parameter :books, 'books the author wrote', scope: :writer


      response_field :name, 'Name of Writer', :scope => :writer, 'Type' => 'String'
      response_field :city, 'Writing hometown', :scope => :writer, 'Type' => 'String'
      response_field :dob, "writer's birth date", :scope => :writer, 'Type' => 'Date'
      response_field :books, 'books the author wrote', :scope => :writer, 'Type' => 'Books'

      let(:name) { 'Writer 1' }
      let(:city) { Faker::Address.city }
      let(:dob) { I18n.l(Faker::Date.birthday(18, 65)) }

      let(:raw_post) { params.to_json }

      example_request 'Creating an writer' do
        explanation 'First, create an writer, then make a later request to get it back'

        writer = JSON.parse(response_body)
        expect(writer.except('id', 'created_at', 'updated_at')).to eq('name' => name,
                                                                    'city' => city,
                                                                    'dob' => dob)
        expect(status).to eq(201)

        client.get(URI.parse(response_headers['location']).path, {}, headers)
        expect(status).to eq(200)
      end
    end

    put "/v1/writers/:id" do
      parameter :name, 'Name of Writer', scope: :writer
      parameter :city, 'Writing hometown', scope: :writer
      parameter :dob, "writer's birth date", scope: :writer
      parameter :books, 'books the author wrote', scope: :writer

      let(:id) { @writer.id }
      let(:name) { "Updated Name" }

      let(:raw_post) { params.to_json }

      example_request "Updating an writer" do
        expect(status).to eq(200)
      end
    end

    delete "/v1/writers/:id" do
      let(:id) { @writer.id }

      example_request "Deleting an writer" do
        expect(status).to eq(204)
      end
    end

  end
end