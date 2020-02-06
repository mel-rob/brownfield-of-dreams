class Repo
  attr_reader :name, :svn_url

  def initialize(attributes = {})
    @name = attributes[:name]
    @svn_url = attributes[:svn_url]
  end
end
