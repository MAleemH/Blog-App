require 'rails_helper'

RSpec.describe 'User Show', type: :feature do
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
    visit user_path @user.id
  end

  it 'I can see the users profile picture' do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'I can see the users username' do
    expect(page).to have_content('Lilly')
  end

  it 'I can see the number of posts the user has written' do
    expect(page).to have_content(@user.posts_counter)
  end

  it 'I can see the users bio' do
    expect(page).to have_content 'Teacher from US.'
  end

  it 'I can see the users first 3 posts' do
    expect(page).to have_content(@forth_post.title)
    expect(page).to have_content(@third_post.title)
    expect(page).to have_content(@second_post.title)
  end

  it 'I can see a button that lets me view all of a users posts' do
    expect(page).to have_link('See all posts')
  end

  it 'When I click a users post, it redirects me to that posts show page' do
    click_link @forth_post.title
    expect(current_path).to eq user_post_path(@user, @forth_post)
  end

  it 'When I click to see all posts, it redirects me to the users posts index page' do
    click_link 'See all posts'
    expect(current_path).to eq user_posts_path(@user)
  end
end
