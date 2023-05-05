require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'is invalid without a title' do
      post = Post.new(title: nil)
      expect(post).to_not be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'is invalid if the title is longer than 250 characters' do
      post = Post.new(title: 'a' * 251)
      expect(post).to_not be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'is valid with a title, author_id, comments_counter and likes_counter' do
      user = User.create(name: 'John', posts_counter: 0)
      post = Post.new(title: 'First post', author_id: user.id, comments_counter: 0, likes_counter: 0)
      expect(post).to be_valid
    end

    it 'is invalid if comments_counter is less than 0' do
      user = User.create(name: 'John', posts_counter: 0)
      post = Post.new(title: 'First post', author_id: user.id, comments_counter: -1, likes_counter: 0)
      expect(post).to_not be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'is invalid if likes_counter is less than 0' do
      user = User.create(name: 'John', posts_counter: 0)
      post = Post.new(title: 'First post', author_id: user.id, comments_counter: 0, likes_counter: -1)
      expect(post).to_not be_valid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end
  end
end
