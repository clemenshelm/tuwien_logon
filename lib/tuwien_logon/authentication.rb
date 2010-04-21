module TuwienLogon
  module Authentication
    def authenticated?(params)
      raise 'You must provide at least a user_id, a host and an skey' unless params[:user_id] && params[:host] && params[:skey]
      
      secret = params[:secret] || TuwienLogon.config.secret
      tolerance = params[:time_tolerance] || TuwienLogon.config.time_tolerance
      offset = params[:server_time_offset] || TuwienLogon.config.server_time_offset
      time = params[:time] || Time.now
      
      auth = Authentication.new params[:user_id], params[:host], secret, tolerance, time + offset
      auth.valid? params[:skey]
    end
  
    class Authentication
      attr_accessor :user_id, :client_host_name, :secret, :timestamp, :tolerance

      def initialize(user_id, client_host_name, secret, tolerance=0, timestamp=Time.now)
        @user_id = user_id.to_s
        @client_host_name = client_host_name.downcase
        @secret= secret.to_s
        @timestamp = timestamp.to_i / 10
        @tolerance = tolerance
      end
    
      def skey(time_offset = 0)
        Digest::SHA1.hexdigest(user_id + (timestamp + time_offset).to_s + client_host_name + secret)
      end
    
      def valid?(skey_to_check)
        (-tolerance..tolerance).each do |time_offset|
          return true if skey(time_offset) == skey_to_check
        end
        false
      end
    end
  end
end