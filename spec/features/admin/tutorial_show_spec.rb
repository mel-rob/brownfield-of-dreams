require 'rails_helper'

describe 'Admin tutorial show page' do
  describe 'As an admin' do
    it 'I can see a tutorial without videos' do
      tutorial_1 = create(:tutorial)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit tutorial_path(tutorial_1)

      expect(page).to have_content('There are no videos in this tutorial.')
      expect(page).to have_link('Add Video')
    end
  end
end
