require 'rails_helper'

describe Repo do
  it 'exists' do
    attrs = {
      name: 'adopt_dont_shop_paired',
      svn_url: 'https://github.com/DanielEFrampton/adopt_dont_shop_paired'
    }

    repo = Repo.new(attrs)

    expect(repo).to be_a Repo
    expect(repo.name).to eq('adopt_dont_shop_paired')
    expect(repo.svn_url).to eq('https://github.com/DanielEFrampton/adopt_dont_shop_paired')
  end
end
