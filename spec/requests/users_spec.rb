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
  end

  describe 'GET /users/:id' do
    let!(:user) { User.create(name: 'Aleem', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', bio: 'Teacher from Poland.', posts_counter: 0) }
    before(:example) { get user_path(user) }

    it 'returns a successful response' do
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end
end
