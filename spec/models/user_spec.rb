require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'John Doe', posts_counter: 3) }

  describe 'validations' do
    it 'requires name' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'requires posts_counter to be an integer greater than or equal to zero' do
      user.posts_counter = -1
      expect(user).to_not be_valid

      user.posts_counter = 0.5
      expect(user).to_not be_valid

      user.posts_counter = 2
      expect(user).to be_valid
    end
  end
end
