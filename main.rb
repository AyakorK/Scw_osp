# frozen_string_literal: true

require 'thor'
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

    > & main.rb get --id <SCW ID>

    > $ main.rb get --name example-instance

    > $ main.rb get --private-ip <SCW PRIVATE IP>

    > $ main.rb get --state <SCW STATE>

    > $ main.rb get --name example-instance --private-ip <SCW PRIVATE IP>

  LONGDESC

  option :id, aliases: '-i', type: :string, desc: 'ID of the server'
  option :name, aliases: '-n', type: :string, desc: 'Name of the instance'
  option :state, aliases: '-s', type: :string, desc: 'State of the instance'
  option :private_ip, aliases: '-pip', type: :string, desc: 'Private IP of the instance'

  def get
    if options.empty?
      Wrapper.new.list
    else
      Wrapper.new.get options
    end
  end

  desc 'checkup', 'Check if any server is down and return the list of those who are'
  def checkup
    Wrapper.new.checkup
  end

  desc 'details', 'Get details of a server using given option'
  long_desc <<-LONGDESC
    Returns details for the given instance

    > $ main.rb details --id <SCW ID>

  LONGDESC

  option :id, aliases: '-i', type: :string, desc: 'ID of the instance'

  def details
    if options.empty?
      Wrapper.new.list
    else
      Wrapper.new.server_details options
    end
  end
end

ScwOsp.start(ARGV)
