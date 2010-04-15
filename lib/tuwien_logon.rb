require 'tuwien_logon/configuration'
require 'tuwien_logon/user_info_request'

module TuwienLogon
  class << self
    def config
      TuwienLogon::Configuration.instance
    end
  end
end