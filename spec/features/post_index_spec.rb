require 'rails_helper'

RSpec.describe 'Post Index', type: :feature do
  before :each do
    @user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from US.',
                        posts_counter: 0)
    @first_post = Post.create(author_id: @user.id, title: 'First Post', text: 'This is my first post.',
                              comments_counter: 0, likes_counter: 0)
    @second_post = Post.create(author_id: @user.id, title: 'Second Post', text: 'This is my second post.',
                               comments_counter: 0, likes_counter: 0)
    @third_post = Post.create(author_id: @user.id, title: 'Third Post', text: 'This is my third post.',
                              comments_counter: 0, likes_counter: 0)
    @forth_post = Post.create(author_id: @user.id, title: 'Forth Post', text: 'This is my forth post.',
                              comments_counter: 0, likes_counter: 0)
    @comment = Comment.create(post_id: @forth_post.id, author_id: @user.id, text: 'This is my first comment')
    @like = Like.create(post_id: @forth_post.id, author_id: @user.id)
    visit user_posts_path @user.id
  end

  it 'I can see the users profile picture' do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'I can see the users username' do
    expect(page).to have_content('Lilly')
  end

  it 'I can see the number of posts each user has written' do
    expect(page).to have_content 'Number of posts: 4'
  end

  it 'I can see a posts title' do
    expect(page).to have_content(@forth_post.title)
    expect(page).to have_content(@third_post.title)
    expect(page).to have_content(@second_post.title)
  end

  it 'I can see some of the posts body' do
    expect(page).to have_content(@forth_post.text)
  end

  it 'I can see the first comments on a post' do
    expect(page).to have_content('Lilly')
  end

  it 'I can see how many comments a post has' do
    expect(page).to have_content('Comment(s): 0')
  end

  it 'I can see how many likes a post has' do
    expect(page).to have_content('Like(s): 0')
  end

  it 'I can see a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_button('Pagination')
  end

  it 'When I click on a post, it redirects me to that posts show page' do
    click_link @forth_post.title
    expect(current_path).to eq user_post_path(@user, @forth_post)
  end
end
