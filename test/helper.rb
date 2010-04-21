require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'tuwien_logon'

class Test::Unit::TestCase
  def setup
    TuwienLogon.config.user_info_url = 'http://localhost:4567/AuthServ.userInfo'
    TuwienLogon.config.secret = '123456'
    TuwienLogon.config.user_info_params = [:oid, :firstname, :lastname, :title, :matriculation_number, :institute_symbol]
  end
end
