require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:id/posts' do
    it 'returns a successful response' do
      get '/users/:id/posts'
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get '/users/:id/posts'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/:id/posts'
      expect(response.body).to include('Here is a list of all all posts by user')
    end
  end

  describe 'GET /users/:id/posts/:id' do
    it 'returns a successful response' do
      get '/users/:id/posts/:id'
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get '/users/:id/posts/:id'
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/:id/posts/:id'
      expect(response.body).to include('Here are details of a post by user')
    end
  end
end
