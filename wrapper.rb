# frozen_string_literal: true

# Class for the Wrapper that will give us our data
class Wrapper
  def initialize
    @server = 'server'
  end

  def list
    # Execute the command 'scw instance server list' and output the result
    puts `scw instance server list`
  end

  def scw_get(param)
    return puts 'Error: Incorrect parameter format, please make a parameter that follows KEY:VALUE'  unless parameter_format?(param)
    key, value = param.downcase.split(':')
    return puts 'Error: Incorrect parameter selected, it must be ID, IP or NAME' unless check_parameter_validity(key)

    key = 'private-ip' if key == 'ip'
    key = 'project-id' if key == 'id'
    puts 'No results found' and return nil if `scw instance server list [#{key}=#{value}]`.empty?

    puts `scw instance server list [#{key}=#{value}]`
  end

  def parameter_format?(param)
    return false unless param.include?(':')

    true
  end

  def check_parameter_validity(key)
    return false unless %w[id ip name].include?(key)

    true
  end
end
