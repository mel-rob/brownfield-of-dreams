require 'rails_helper'

describe 'vister can see about page' do
  it 'shows about information' do

    visit '/about'

    expect(page).to have_content('Turing Tutorials')
    expect(page).to have_content("This application is designed to pull in youtube information to populate tutorials from Turing School of Software and Design's youtube channel. It's designed for anyone learning how to code, with additional features for current students.")
  end
end
