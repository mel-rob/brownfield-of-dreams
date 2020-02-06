class GithubSearch
  attr_reader :github_token

  def initialize(github_token)
    @github_token = github_token
  end

  def repos
    service = GithubService.new
    service.repos_by_token(@github_token).map do |repo_data|
      Repo.new(repo_data)
    end
  end
end
