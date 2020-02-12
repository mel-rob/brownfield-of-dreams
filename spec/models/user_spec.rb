require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    it 'order_videos' do
      user = create(:user)

      tutorial_1 = create(:tutorial)
      video_1 = create(:video, tutorial_id: tutorial_1.id, position: 1)
      video_2 = create(:video, tutorial_id: tutorial_1.id, position: 2)
      user_video_1 = create(:user_video, user_id: user.id, video_id: video_1.id)
      user_video_2 = create(:user_video, user_id: user.id, video_id: video_2.id)

      tutorial_2 = create(:tutorial)
      video_3 = create(:video, tutorial_id: tutorial_2.id, position: 1)
      video_4 = create(:video, tutorial_id: tutorial_2.id, position: 2)
      video_5 = create(:video, tutorial_id: tutorial_2.id, position: 3)
      user_video_3 = create(:user_video, user_id: user.id, video_id: video_3.id)
      user_video_4 = create(:user_video, user_id: user.id, video_id: video_4.id)
      user_video_5 = create(:user_video, user_id: user.id, video_id: video_5.id)

      videos_hash = {
        tutorial_1 => [video_1, video_2],
        tutorial_2 => [video_3, video_4, video_5]
      }

      expect(user.order_videos).to eq(videos_hash)
    end
  end
end
