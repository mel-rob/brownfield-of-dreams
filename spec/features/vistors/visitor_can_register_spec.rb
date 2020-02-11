require 'rails_helper'

describe 'vister can create an account', :js do
  it ' visits the home page' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    mailer_count = ActionMailer::Base.deliveries.count
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
    expect(ActionMailer::Base.deliveries.count).to eq(mailer_count + 1)
  end

  it 'is not able to create an account if the username already exists' do
    create(:user, email: 'user@email.com')

    email = 'user@email.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit new_user_path

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Create Account'

    expect(current_path).to eq(register_path)
    expect(page).to have_content('Username already exists')
  end

  it 'gets activated when confirming via email' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'
    click_on 'Sign In'
    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'
    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password
    click_on 'Create Account'

    expect(User.count).to eq(1)
    user = User.last

    expect(page).to have_content('Account Status: Inactive - Please check your email')
    expect(user.active?).to eq(false)
    visit "/email_confirmation/#{user.id}"
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Account Status: Active')
    expect(User.find(user.id).active?).to eq(true)
  end
end
