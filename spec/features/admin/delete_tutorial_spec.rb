require 'rails_helper'

describe 'Admin dashboard page' do
  describe 'As an admin' do
    it 'I can delete tutorials' do
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      expect(page).to have_css(".admin-tutorial-card", count: 2)

      within(first(".admin-tutorial-card")) do
        click_button "Destroy"
      end

      expect(current_path).to eq(admin_dashboard_path)

      expect(page).to_not have_content(tutorial_1.title)
      expect(page).to have_content(tutorial_2.title)
    end

    it 'videos are deleted when deleting tutorials' do
      tutorial_1 = create(:tutorial)
      video_1 = create(:video, tutorial_id: tutorial_1.id)
      video_2 = create(:video, tutorial_id: tutorial_1.id)

      tutorial_2 = create(:tutorial)
      video_3 = create(:video, tutorial_id: tutorial_2.id)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      within "##{tutorial_1.id}" do
        click_button "Destroy"
      end

      expect{Video.find(video_1.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect{Video.find(video_2.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(Video.find(video_3.id)).to eq(video_3)
    end
  end
end
