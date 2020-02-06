require 'rails_helper'

describe GithubService do
  context 'instance methods' do
    it 'returns repo data' do
      user = create(:user, github_token: 'eb9bda32691b14e57d80820ebf5fc625b3d885ff')
      search = subject.repos_by_token(user.github_token)
      expect(search).to be_a Array
      expect(search.count).to eq 5
      repo_data = search.first

      expect(repo_data).to have_key :name
      expect(repo_data).to have_key :svn_url
    end
  end
end
