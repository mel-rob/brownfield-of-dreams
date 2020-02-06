class GithubSearch

  def initialize(github_token)
    @github_token = github_token
  end

  def repos
    @repos ||= get_repos
  end

  def get_repos
    service = GithubService.new
    service.repos_by_token(@github_token).map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def followers
    @followers ||= get_followers
  end

  def get_followers
    service = GithubService.new
    service.followers_by_token(@github_token).map do |follower_data|
      Follower.new(follower_data)
    end
  end
end
