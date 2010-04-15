module TuwienLogon
  class UserInfo
    attr_accessor :params, :info
    
    class << self
      def find_by_oid(oid)
        request = TuwienLogon::UserInfoRequest.new
        request.get_user_info :oid => oid
      end
    end
    
    def initialize(params = [])
      @params = params
      @info = {}
    end
    
    def method_missing(param, *args)
      if param.to_s[-1] == '='
        setter = true
        param = param.to_s[0..-2].to_sym
      end
      
      if params.include? param
        info[param] = args[0] if setter
        info[param]
      else
        super(param, args);
      end
    end
  end
end