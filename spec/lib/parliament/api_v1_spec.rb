require 'spec_helper'
require 'rack/test'

RSpec.describe Parliament::APIv1 do
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      run Parliament::APIv1
    end
  end

  def assert_last_response_matches(expected_data)
    data = JSON.parse(last_response.body)
    expect(data).to eq(expected_data)
  end

  before do
    # before
  end

  describe 'GET /parties' do
    it 'is a pending example'
  end
end
