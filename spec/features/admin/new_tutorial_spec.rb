require 'rails_helper'

describe 'Admin can create tutorial' do
  describe 'As an admin' do
    before(:each) do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end

    it 'I can create a new tutorial' do

      visit admin_dashboard_path

      expect(page).to_not have_content("Mod 4")

      click_on 'New Tutorial'

      fill_in "tutorial[title]", with: "Mod 4"
      fill_in "tutorial[description]", with: "Time for the good stuff."
      fill_in "tutorial[thumbnail]", with: "J7ikFUlkP_k"
      click_on "Save"

      tutorial = Tutorial.last

      expect(current_path).to eq(tutorial_path(tutorial))
      expect(page).to have_content('Successfully created tutorial.')

      visit admin_dashboard_path

      expect(page).to have_content(tutorial.title)
    end

    it 'I am not able to create a tutorial without filling in required fields' do
      visit admin_dashboard_path
      click_on 'New Tutorial'

      fill_in "tutorial[title]", with: ""
      fill_in "tutorial[description]", with: "Time for the good stuff."
      fill_in "tutorial[thumbnail]", with: "J7ikFUlkP_k"
      click_on "Save"

      expect(page).to have_content("Title can't be blank")
      expect(page).to have_button 'Save'

      fill_in "tutorial[title]", with: "Mod 4"
      fill_in "tutorial[description]", with: ""
      fill_in "tutorial[thumbnail]", with: "J7ikFUlkP_k"
      click_on "Save"

      expect(page).to have_content("Description can't be blank")
      expect(page).to have_button 'Save'

      fill_in "tutorial[title]", with: "Mod 4"
      fill_in "tutorial[description]", with: "I'm a new description!"
      fill_in "tutorial[thumbnail]", with: ""
      click_on "Save"

      expect(page).to have_content("Thumbnail can't be blank")
      expect(page).to have_button 'Save'

      fill_in "tutorial[title]", with: "Mod 4"
      fill_in "tutorial[description]", with: "Time for the good stuff."
      fill_in "tutorial[thumbnail]", with: "J7ikFUlkP_k"
      click_on "Save"

      tutorial = Tutorial.last

      visit admin_dashboard_path

      expect(page).to have_content(tutorial.title)
    end
  end
end
