# frozen_string_literal: true

class GithubService
  def initialize(github_token)
    @github_token = github_token
  end

  def repos_by_token
    @repos_by_token ||= get_json('/user/repos?page=1&per_page=5')
  end

  def followers_by_token
    @followers_by_token ||= get_json('/user/followers')
  end

  def following_by_token
    @following_by_token ||= get_json('/user/following')
  end

  def valid_token?
    get_json('/user')[:message] != 'Bad credentials'
  end

  def email_by_username(github_username)
    get_json("/users/#{github_username}")[:email]
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{@github_token}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
