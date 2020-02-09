require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:position)}
    it {should belong_to(:tutorial)}
    it {should have_many(:user_videos)}
    it {should have_many(:users).through(:user_videos)}
  end
end
