class GithubSearch

  def initialize(github_token)
    @service = GithubService.new(github_token)
  end

  def repos
    @repos ||= get_repos
  end

  def get_repos
    @service.repos_by_token.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def followers
    @followers ||= get_followers
  end

  def get_followers
    @service.followers_by_token.map do |follower_data|
      GithubUser.new(follower_data)
    end
  end

  def following
    @following ||= get_following
  end

  def get_following
    @service.following_by_token.map do |following_data|
      GithubUser.new(following_data)
    end
  end
end
