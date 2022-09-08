# frozen_string_literal: true

require_relative 'wrapper'

# Class for the command line interface
class Scw_osp < Thor
  desc 'list', 'List all servers'
  def list
    Wrapper.new.list
  end
  desc 'get <ID:|IP:|NAME:>', 'Get informations of a server using ID'
  def get(param)
    Wrapper.new.scw_get(param)
  end
end
