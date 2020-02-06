class GithubService
  # OPTIMIZE: should github_token be an attribute of GitHubService?
  # OPTIMIZE: why is repos_by_token an instance method and not class method?

  def repos_by_token(github_token)
    @github_token = github_token
    get_json("/user/repos?page=1&per_page=5")
  end

  def followers_by_token(github_token)
    @github_token = github_token
    get_json("/user/followers")
  end

  private
  def get_json(url)
    response = conn.get(url)
    json_response = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers["Authorization"] = "token #{@github_token}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
