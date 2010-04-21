require 'helper'

class TestTuwienLogon < Test::Unit::TestCase
  should "set the user info url url directly" do
    url = 'abc'
    TuwienLogon.config.user_info_url = url
    assert_equal url, TuwienLogon.config.user_info_url
  end
  
  should "set the user info url url by a block" do
    url = 'abc'
    TuwienLogon.configuration do |config|
      config.user_info_url = url
    end
    assert_equal url, TuwienLogon.config.user_info_url
  end
end
