require 'rails_helper'

RSpec.describe 'user invite page' do
  it 'user can access invite page from dashboard' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)

    click_on('Send an Invite')

    expect(current_path).to eq('/invite')
  end
end
