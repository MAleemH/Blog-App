require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'returns a successful response' do
      get '/users'
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('Here is a list of all users')
    end
  end

  describe 'GET /users/:id' do
    it 'returns a successful response' do
      get '/users/:id'
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get '/users/:id'
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/:id'
      expect(response.body).to include('Here are details of a user')
    end
  end
end
