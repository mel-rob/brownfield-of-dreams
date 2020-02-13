require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is sent to the log in page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    find('.tooltiptext').should have_content('Please log in or register to bookmark videos')

    expect(current_path).to eq(tutorial_path(tutorial))
  end
end
