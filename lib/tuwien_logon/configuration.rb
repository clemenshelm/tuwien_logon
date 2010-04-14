require 'singleton'

module TuwienLogon
  class Configuration
    include Singleton
    
    attr_accessor :authentication_url, :user_info_url, :secret
    
    def initialize
      @authentication_url = 'https://iu.zid.tuwien.ac.at/AuthServ.authenticate'
      @user_info_url = 'https://iu.zid.tuwien.ac.at/AuthServ.userInfo'
      @secret = '123456'
    end
  end
end