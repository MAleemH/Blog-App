require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  before :each do
    @user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from US.',
                        posts_counter: 0)
    @post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my first post.', comments_counter: 0,
                        likes_counter: 0)
    visit root_path
  end

  it 'I can see the username of all other users' do
    expect(page).to have_content('Lilly')
  end

  it 'I can see the profile picture for each user' do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'I can see the number of posts each user has written' do
    expect(page).to have_content 'Number of posts: 1'
  end

  it 'When I click on a user, I am redirected to that users show page' do
    click_on 'Lilly'
    expect(page).to have_content 'Lilly'
  end
end
