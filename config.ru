$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), *%w[lib]))
require 'aresmush'

server = AresMUSH::AresWeb.run!