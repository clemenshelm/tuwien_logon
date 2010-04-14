require 'helper'

class TestTuwienLogon < Test::Unit::TestCase
  should "set the authentication url correctly" do
    url = 'abc'
    TuwienLogon.config.authentication_url = url
    assert_equal url, TuwienLogon.config.authentication_url
  end
  
  should "set the user info url correctly" do
    url = 'abc'
    TuwienLogon.config.user_info_url = url
    assert_equal url, TuwienLogon.config.user_info_url
  end
  
  should "set the secret correctly" do
    url = 'abc'
    TuwienLogon.config.secret = url
    assert_equal url, TuwienLogon.config.secret
  end
end
