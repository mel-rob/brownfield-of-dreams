class GithubService

  def repos_by_token(github_token)
    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers["Authorization"] = "token #{github_token}"
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/user/repos?page=1&per_page=5")
    json_response = JSON.parse(response.body, symbolize_names: true)
  end
end
