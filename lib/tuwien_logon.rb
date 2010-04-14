require 'tuwien_logon/configuration'

module TuwienLogon
  class << self
    def config
      TuwienLogon::Configuration.instance
    end
  end
end