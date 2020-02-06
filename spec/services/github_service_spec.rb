require 'rails_helper'

describe GithubService do
  context 'instance methods' do
    scenario 'returns repo data', :vcr do
      user = create(:user, github_token: ENV['AUTHORIZATION'])
      search = subject.repos_by_token(user.github_token)
      expect(search).to be_a Array
      expect(search.count).to eq 5
      repo_data = search.first

      expect(repo_data).to have_key :name
      expect(repo_data).to have_key :svn_url
    end
  end
end
