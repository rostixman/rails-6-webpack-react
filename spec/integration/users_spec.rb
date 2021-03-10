require 'swagger_helper'

describe 'Users API' do

  path '/api/v1/users' do

    get 'Get list of users' do
      tags 'Users'
      consumes 'application/json'

      response '200', 'pet created' do
        let(:user) { { name: 'Dodo', status: 'available' } }
        run_test!
      end
    end

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json', 'application/xml'


      response '201', 'pet created' do
        let(:user) { { name: 'Dodo', status: 'available' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: 'foo' } }
        run_test!
      end
    end
  end
end