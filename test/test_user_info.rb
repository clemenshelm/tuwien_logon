require 'helper'
require 'tuwien_logon/user_info'

class TestUserInfo < Test::Unit::TestCase
  context "A user info object" do
    should "find correct user info" do
      info = TuwienLogon::UserInfo.find_by_oid(1231132)
      assert_equal '1231132', info.oid
      assert_equal 'Ernst', info.firstname
      assert_equal 'Orwell', info.lastname
      assert_nil info.title
      assert_equal '0812345', info.matriculation_number
      assert_nil info.institute_symbol
    end
  end
end