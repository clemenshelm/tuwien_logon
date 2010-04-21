require 'singleton'

module TuwienLogon
  class Configuration
    include Singleton
    
    attr_accessor :user_info_url, :secret, :user_info_params, :time_tolerance, :server_time_offset
    
    def initialize
      @user_info_url = 'https://iu.zid.tuwien.ac.at/AuthServ.userInfo'
      @secret = '123456'
      @user_info_params = [:oid, :firstname, :lastname, :title, :matriculation_number, :institute_symbol]
      @time_tolerance = 5
      @server_time_offset = 0
    end
  end
end