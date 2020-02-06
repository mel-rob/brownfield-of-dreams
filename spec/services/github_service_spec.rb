require 'rails_helper'

describe GithubService do
  context 'instance methods' do
    scenario 'returns repo data', :vcr do
      github_service = GithubService.new(ENV['GITHUB_ACCESS_TOKEN'])
      search = github_service.repos_by_token
      expect(search).to be_a Array
      expect(search.count).to eq 5
      repo_data = search.first

      expect(repo_data).to have_key :name
      expect(repo_data).to have_key :svn_url
    end

    scenario 'returns follower data', :vcr do
      github_service = GithubService.new(ENV['GITHUB_ACCESS_TOKEN'])
      search = github_service.followers_by_token
      expect(search).to be_a Array
      expect(search.count).to eq 2
      follower_data = search.first

      expect(follower_data).to have_key :login
      expect(follower_data).to have_key :html_url
    end

    scenario 'returns following data', :vcr do
      github_service = GithubService.new(ENV['GITHUB_ACCESS_TOKEN'])
      search = github_service.following_by_token
      expect(search).to be_a Array
      expect(search.count).to eq 2
      follower_data = search.first

      expect(follower_data).to have_key :login
      expect(follower_data).to have_key :html_url
    end
  end
end
