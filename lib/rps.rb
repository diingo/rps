# Create our module. This is so other files can start using it immediately

module RPS
end


# Require all of our project files
# require_relative 'rps/player.rb'
# require_relative 'rps/match.rb'
# require_relative 'rps/round.rb'
# require_relative 'rps/db.rb'
# require_relative 'rps/session.rb'
# require_relative 'use_case.rb'


# this looks nicer but doesn't work
# Dir["task-manager/use_cases/*"].each {|file| require file }

# adds all files in /rps
Dir["#{File.dirname(__FILE__)}/rps/*.rb"].each { |f| require(f) }

require 'pry-debugger'