# frozen_string_literal: true

require "thor"
require_relative 'wrapper'

# Class for the command line interface
class ScwOsp < Thor
  desc 'list', 'List all servers'
  def list
    Wrapper.new.list
  end

  desc 'get', 'Get informations of a server using given option'
  long_desc <<-LONGDESC
    Returns information for the given instance

    > $ main.rb get --name example-instance

    > $ main.rb get --id <SCW ID>

    > $ main.rb get --private-ip <SCW PRIVATE IP>

    > $ main.rb get --public-ip <SCW PUBLIC IP>
  LONGDESC

  option :name, aliases: "-n"
  option :private_ip, aliases: "-p"

  def get
    if options.empty?
      Wrapper.new.list
    else
      Wrapper.new.get options
    end
  end
end

ScwOsp.start(ARGV)