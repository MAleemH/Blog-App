require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it 'is valid with a text and author_id' do
      user = User.create(name: 'John', posts_counter: 0)
      post = Post.create(title: 'First post', author_id: user.id, comments_counter: 0, likes_counter: 0)
      comment = Comment.new(text: 'Great post!', author_id: user.id, post_id: post.id)
      expect(comment).to be_valid
    end
  end
end
