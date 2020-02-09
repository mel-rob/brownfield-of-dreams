require 'rails_helper'

describe "tutorial show page" do
  it "user can see a classroom tutorial" do
    tutorial = create(:tutorial, title: "How to Tie Your Shoes", classroom: true)
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end
end
