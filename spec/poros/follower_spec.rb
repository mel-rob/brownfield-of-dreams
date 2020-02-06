require 'rails_helper'

describe Follower do
  it 'exists' do
    attrs = {
      login: 'mel-rob',
      html_url: 'https://github.com/mel-rob'
    }

    follower = Follower.new(attrs)

    expect(follower).to be_a Follower
    expect(follower.login).to eq('mel-rob')
    expect(follower.html_url).to eq('https://github.com/mel-rob')
  end
end
