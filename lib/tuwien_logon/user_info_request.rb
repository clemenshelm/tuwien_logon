require 'net/http'
require 'net/https'
require 'tuwien_logon/user_info'

module TuwienLogon
  class UserInfoRequest
    attr_accessor :url
    
    def initialize(url = TuwienLogon.config.user_info_url)
      @url = URI.parse(url)
    end
    
    def split_response(response)
      response.strip.split("\t")
    end
    
    def get_user_info(params = {})
      create_user_info(get(params))
    end
    
    def create_user_info(infos = [], params = TuwienLogon.config.user_info_params)
      infos = split_response(infos.to_s) unless infos.is_a? Array
        
      userdata = TuwienLogon::UserInfo.new(params)
      params.each_with_index do |param, index|
        userdata.send("#{param}=".to_sym, infos[index]) unless infos[index].nil? || infos[index].empty?
      end
      userdata
    end
    
    def get(params = {})
      url.query = query_string(params)
      Net::HTTP.get_response(url).body
    end
    
    def query_string(params = {})
      params.map { |key, value| "#{key}=#{value}" }.join('&')
    end
  end
end