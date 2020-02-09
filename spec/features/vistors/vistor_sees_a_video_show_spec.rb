require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))

  end

  it "visitor can see a tutorial show view" do
    tutorial = create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)

    visit tutorial_path(tutorial)

    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end

  it "visitor cannot see a classroom tutorial" do
    tutorial = create(:tutorial, title: "How to Tie Your Shoes", classroom: true)
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)

    visit tutorial_path(tutorial)

    within ".error-flash" do
      expect(page).to have_content("User must login to view classroom tutorials")
    end
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page).not_to have_content(video.title)
    expect(page).not_to have_content(tutorial.title)
  end
end
