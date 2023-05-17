require 'rails_helper'

describe 'User index page', type: :feature do
  before :each do
    User.create(id: 1, name: 'user1', photo: 'photo1', bio: 'a test user', posts_counter: 0)
    User.create(id: 2, name: 'user2', photo: 'photo1', bio: 'a test user', posts_counter: 0)
    user = User.create(id: 3, name: 'user3', photo: 'photo1', bio: 'a test user', posts_counter: 0)

    user.posts.create(title: 'title1', text: 'text1', likes_counter: 0, comments_counter: 0)

    visit '/users'
  end

  it 'I can see the username of all other users.' do
    expect(page).to have_content 'user1'
    expect(page).to have_content 'user2'
    expect(page).to have_content 'user3'

    expect(page).to have_selector('.user__name', count: 3)
  end

  it 'I can see the profile picture for each user.' do
    expect(page).to have_selector('.user__picture', count: 3)
  end

  it 'I can see the number of posts of all other users.' do
    expect(page).to have_content('Number of posts: 0', count: 2)
    expect(page).to have_content('Number of posts: 1', count: 1)

    expect(page).to have_selector('.user__posts-count', count: 3)
  end

  it 'When I click on a user, I am redirected to that users show page.' do
    click_on 'user1'

    expect(page).to have_current_path('/users/1')
  end
end

describe 'Use page show ', type: :feature do
  before :each do
    @user1 = User.create(id: 1, name: 'user1', photo: 'photo1', bio: 'a test user', posts_counter: 0)
    @user2 = User.create(id: 2, name: 'user2', photo: 'photo1', bio: 'a test user', posts_counter: 0)

    @post1 = Post.create(title: 'title1', text: 'post1', likes_counter: 0, comments_counter: 0, author: @user1)
    @post2 = Post.create(title: 'title2', text: 'post2', likes_counter: 0, comments_counter: 0, author: @user1)
    @post2 = Post.create(title: 'title2', text: 'post3', likes_counter: 0, comments_counter: 0, author: @user1)

    visit user_path(@user1.id)
    I18n.locale = :en
  end

  it "user's profile picture" do
    all('img').each do |i|
      expect(i[:src]).to eq('photo1.png')
    end
  end
  it "show user's name" do
    expect(page).to have_content 'user1'
  end
  it 'number of posts per user' do
    expect(page).to have_content(1)
  end

  it "show user's bio" do
    expect(page).to have_content('a test user')
  end

  it "show user's first 3 posts" do
    expect(page).to have_content 'post1'
    expect(page).to have_content 'post2'
    expect(page).to have_content 'post3'
  end

  it "show button that lets me view all of a user's posts." do
    expect(page).to have_link(I18n.t('users.show.see_all_posts'))
  end

  it "When I click a user's post, it redirects me to that post's show page" do
    click_link I18n.t('users.show.see_all_posts')
    expect(page).to have_current_path user_posts_path(@user1, @post_1)
  end

  it "When I click to see all posts, it redirects me to the user's post's index page" do
    click_link I18n.t('users.show.see_all_posts')
    expect(page).to have_current_path user_posts_path(@user1)
  end
end
