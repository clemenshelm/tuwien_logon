require 'helper'
require 'tuwien_logon/authentication'

class TestAuthentication < Test::Unit::TestCase
  include TuwienLogon::Authentication
  
  context 'The authentication' do
    setup do
      @time = Time.now
      @authentication = Authentication.new 1, 'client', 'secret', 0, @time
    end
    
    should 'generate the correct skey' do
      assert_equal correct_key(@authentication, @time), @authentication.skey
    end
    
    should 'generate the incorrect skey' do
      key = Digest::SHA1.hexdigest("1clientsecret")
      
      assert_not_equal key, @authentication.skey
    end
    
    should 'generate the correct skey with time offset' do
      offset = 10
      assert_equal correct_key(@authentication, @time + offset * 10), @authentication.skey(offset)
    end
    
    should 'generate the incorrect skey with wrong time offset' do
      assert_not_equal correct_key(@authentication, @time + 1000), @authentication.skey(10)
    end
    
    should 'validate a correct key' do
      assert @authentication.valid? correct_key(@authentication, @time)
    end
    
    should 'not validate an incorrect key' do
      assert !(@authentication.valid? correct_key(@authentication, @time + 10))
    end
    
    should 'validate a correct key with tolerance' do
      @authentication.tolerance = 5
      assert @authentication.valid? correct_key(@authentication, @time + 50)
      assert @authentication.valid? correct_key(@authentication, @time - 50)
    end
    
    should 'not validate a key out of tolerance' do
      @authentication.tolerance = 5
      assert !(@authentication.valid? correct_key(@authentication, @time + 100))
      assert !(@authentication.valid? correct_key(@authentication, @time - 100))
    end
    
    context 'method' do
      should 'raise an exception if there are not all required arguments' do
        [:user_id, :host, :skey].each do |param|
          hash = authentication_hash(@authentication)
          hash.delete param
          assert_raise(RuntimeError) { authenticated? hash }
        end
      end
      
      should 'authenticate a valid user' do
        assert authenticated? authentication_hash(@authentication)
      end

      should 'not authenticate an invalid user' do
        hash = authentication_hash(@authentication)
        hash[:user_id] = 2

        assert !(authenticated? hash)
      end

      should 'authenticate a user with time offset' do
        hash = authentication_hash(@authentication)
        hash[:server_time_offset] = 1000
        hash[:time] = Time.now - 1000

        assert authenticated? hash
      end

      should 'not authenticate a user with wrong time offset' do
        hash = authentication_hash(@authentication)
        hash[:server_time_offset] = 1000

        assert !(authenticated? hash)
      end
    end
  end
  
  def correct_key(authentication, time)
    Digest::SHA1.hexdigest("#{authentication.user_id}#{time.to_i / 10}#{authentication.client_host_name}#{authentication.secret}")
  end
  
  def authentication_hash(authentication)
    {
      :user_id => @authentication.user_id,
      :host => @authentication.client_host_name,
      :skey => correct_key(@authentication, @time),
      :secret => @authentication.secret
    }
  end
end