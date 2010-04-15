require 'singleton'

module TuwienLogon
  class Configuration
    include Singleton
    
    attr_accessor :authentication_url, :user_info_url, :secret, :user_info_params
    
    def initialize
      @authentication_url = 'https://iu.zid.tuwien.ac.at/AuthServ.authenticate'
      @user_info_url = 'https://iu.zid.tuwien.ac.at/AuthServ.userInfo'
      @secret = '123456'
      @user_info_params = [:oid, :firstname, :lastname, :title, :matriculation_number, :institute_symbol]
    end
  end
end