require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe 'GET /users/:id/posts' do
    it 'returns a successful response' do
      get '/users/:id/posts'
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id/posts/:id' do
    it 'returns a successful response' do
      get '/users/:id/posts/:id'
      expect(response).to have_http_status(200)
    end
  end
end
