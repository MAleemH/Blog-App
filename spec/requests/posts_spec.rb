require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create(name: 'Aleem', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', bio: 'Teacher from Poland.', posts_counter: 0) }
  let!(:post) { Post.create(author: user, title: 'My blog', comments_counter: 0, likes_counter: 0) }

  describe 'GET /users/:id/posts' do
    it 'returns a successful response' do
      get user_posts_path(user_id: user.id)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get user_posts_path(user_id: user.id)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /users/:id/posts/:id' do
    it 'returns a successful response' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to render_template(:show)
    end
  end
end
