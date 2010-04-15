require 'helper'
require 'tuwien_logon/user_info_request'

class TestUserInfoRequest < Test::Unit::TestCase
  context "A user info request" do
    setup do
      @request = TuwienLogon::UserInfoRequest.new
      @request.url.query = 'oid=8761231'
    end

    should "parse a url correctly" do
      assert_equal 'localhost', @request.url.host
      assert_equal '/AuthServ.userInfo', @request.url.path
      assert_equal 4567, @request.url.port
      assert_equal 'http', @request.url.scheme
      assert_equal 'oid=8761231', @request.url.query
    end
  
    should "map params correctly" do
      query = @request.query_string(:a => 'b', :c => 'd')
      assert_equal 'a=b&c=d', query
    end
  
    should "parse user info correctly" do
      data = "124\tAlbert\tEinstein\tDr.\t0123456\tabc\n"
      info = @request.create_user_info data, [:oid, :firstname, :lastname, :title, :matriculation_number, :institute_symbol]
      assert_equal '124', info.oid
      assert_equal 'Albert', info.firstname
      assert_equal 'Einstein', info.lastname
      assert_equal 'Dr.', info.title
      assert_equal '0123456', info.matriculation_number
      assert_equal 'abc', info.institute_symbol
    end
    
    # for the following tests mockzid must be running at localhost:4567
    
    should "retrieve correct reply" do
      reply = @request.get :oid => 8761231
      assert_equal "8761231\tKarl\tPopper\tProf.\t\tE123\n", reply
    end
    
    should "get the correct user info" do
      info = @request.get_user_info(:oid => 1231132)
      assert_equal '1231132', info.oid
      assert_equal 'Ernst', info.firstname
      assert_equal 'Orwell', info.lastname
      assert_nil info.title
      assert_equal '0812345', info.matriculation_number
      assert_nil info.institute_symbol
    end
  end
end