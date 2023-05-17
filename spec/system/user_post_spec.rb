require 'rails_helper'

describe 'User post index page', type: :feature do
  before :each do
    user = User.create(id: 1, name: 'user1', photo: 'photo1', bio: 'a test user', posts_counter: 0)

    user.posts.create(id: 1, title: 'title1', text: 'text1', likes_counter: 0, comments_counter: 0)
    user.posts.create(id: 2, title: 'title2', text: 'text2', likes_counter: 0, comments_counter: 0)
    user.posts.create(id: 3, title: 'title3', text: 'text3', likes_counter: 0, comments_counter: 0)
    user.posts.create(id: 4, title: 'title4', text: 'text4', likes_counter: 0, comments_counter: 0)
    @post = user.posts.create(id: 5, title: 'title5', text: 'a very long text description jus for testing',
                              likes_counter: 0, comments_counter: 0)

    @post.comments.create(text: 'comment1', author: user)
    @post.likes.create(author: user)
    @post.likes.create(author: user)

    I18n.locale = :en

    visit user_posts_path(user.id)
  end

  it 'I can see the user\'s profile picture.' do
    expect(page).to have_selector('.user__picture', count: 1)
  end

  it 'I can see the user\'s username.' do
    expect(page).to have_content 'user1'
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content 'Number of posts: 5'
  end

  it 'I can see a post\'s title.' do
    expect(page).to have_content 'title1'
  end

  it 'I can see some of the post\'s body.' do
    expect(page).to have_content "#{@post.text[0..16]}..."
  end

  it 'I can see the first comments on a post.' do
    expect(page).to have_content 'title1'
    expect(page).to have_content 'text1'
    expect(page).to have_content 'Comments: 0'
    expect(page).to have_content 'Likes: 0'
  end

  it 'I can see how many comments a post has.' do
    expect(page).to have_content('Comments: 1', count: 1)
  end

  it 'I can see how many likes a post has.' do
    expect(page).to have_content('Likes: 2', count: 1)
  end

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
    expect(page).to have_button(I18n.t('common.pagination'))
  end

  it 'When I click on a post, it redirects me to that post\'s show page.' do
    click_on 'title1'

    expect(page).to have_current_path(user_post_path(1, 1))
  end
end

describe 'Post show page', type: :feature do
  before :each do
    @user1 = User.create(id: 1, name: 'user1', photo: 'photo1', bio: 'a test user', posts_counter: 0)

    @post1 = Post.create(title: 'title1', text: 'post1', likes_counter: 0, comments_counter: 0, author: @user1)
    @post2 = Post.create(title: 'title2', text: 'post2', likes_counter: 0, comments_counter: 0, author: @user1)
    @post2 = Post.create(title: 'title2', text: 'post3', likes_counter: 0, comments_counter: 0, author: @user1)

    @comment1 = Comment.create(text: 'comment1', author: User.first, post: Post.first)
    @comment2 = Comment.create(text: 'comment2', author: User.first, post: Post.first)
    @comment3 = Comment.create(text: 'comment3', author: User.first, post: Post.first)
    visit user_posts_path(@user1, @post1)
  end

  it 'shows posts title' do
    expect(page).to have_content('post1')
  end

  it 'shows the person who wrote the post' do
    expect(page).to have_content('user1')
  end

  it 'shows number of comments' do
    post = Post.first
    expect(post.comments_counter).to eql(3)
  end

  it 'see the post body.' do
    expect(page).to have_content('post1')
  end

  it 'see username of each commentor' do
    expect(page).to have_content('user1')
  end

  it 'shows number of likes' do
    post = Post.first
    expect(page).to have_content(post.likes_counter)
  end

  it 'see the comments of each commentor' do
    expect(@comment1.text).to eq('comment1')
    expect(@comment2.text).to eq('comment2')
    expect(@comment3.text).to eq('comment3')
  end
end
