require 'rails_helper'

describe GithubUser do
  it 'exists' do
    attrs = {
      login: 'mel-rob',
      html_url: 'https://github.com/mel-rob'
    }

    github_user = GithubUser.new(attrs)

    expect(github_user).to be_a GithubUser
    expect(github_user.login).to eq('mel-rob')
    expect(github_user.html_url).to eq('https://github.com/mel-rob')
  end
end
