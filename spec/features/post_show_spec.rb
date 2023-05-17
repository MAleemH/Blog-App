require 'rails_helper'

RSpec.describe 'Post Show', type: :feature do
  before :each do
    @user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from US.',
                        posts_counter: 0)
    @first_post = Post.create(author_id: @user.id, title: 'First Post', text: 'This is my first post.',
                              comments_counter: 0, likes_counter: 0)
    @comment = Comment.create(post_id: @first_post.id, author_id: @user.id, text: 'This is my first comment')
    @like = Like.create(post_id: @first_post.id, author_id: @user.id)
    visit user_post_path(@user, @first_post)
  end

  it 'I can see the posts title' do
    expect(page).to have_content 'First Post'
  end

  it 'I can see who wrote the post' do
    expect(page).to have_content 'Lilly'
  end

  it 'I can see how many comments it has' do
    expect(page).to have_content('Comment(s): 1')
  end

  it 'I can see how many likes it has' do
    expect(page).to have_content('Like(s): 1')
  end

  it 'I can see the post body' do
    expect(page).to have_content 'This is my first post.'
  end

  it 'I can see the username of each commentor' do
    expect(page).to have_content(@comment.author.name)
  end

  it 'I can see the comment each commentor left' do
    expect(page).to have_content 'This is my first comment'
  end
end
