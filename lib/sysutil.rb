require "sysutil/version/version"
require "sysutil/functions"
require "sysutil/config"

module Sysutil
  include Config
end

require "sysutil/user"
require "sysutil/package"



require "sysutil/railtie" if defined?(Rails)
