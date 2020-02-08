require 'rails_helper'

describe 'tutorial show page' do
  it 'vistor sees tutorial show page when there are no videos' do
    tutorial = create(:tutorial)

    visit tutorial_path(tutorial)

    expect(page).to have_content('There are no videos in this tutorial.')
    expect(page).to_not have_link('Add Video')
  end
end
