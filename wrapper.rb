# frozen_string_literal: true

require 'colorize'

# Class for the command line error interface
class NoResultError < StandardError
  def initialize(msg = 'Error: No Results Found')
    super
  end
end

# Class for the command line error interface
class InvalidKey < StandardError
  def initialize(msg = 'Error: Incorrect parameter selected, it must be an ID')
    super
  end
end

# Class for the Wrapper that will give us our data
class Wrapper
  def initialize
    @server = 'server'
  end

  def list
    # Execute the command 'scw instance server list' and output the result
    puts `scw instance server list`
  end

  def get(options)
    search = ''
    options.each do |option|
      search += "#{option[0].gsub('_', '-')}=#{option[1]} "
    end

    puts search
    instance = `scw instance server list #{search}`
    # If instance contains only letters, it means that the search didn't return any results
    raise NoResultError unless instance.match?(/\d+/)

    puts instance.colorize(:green)
  rescue NoResultError => e
    puts "[#{e.class}] - #{e.message}".colorize(:red)
  end

  def checkup
    instance = `scw instance server list state=stopped`
    if instance.match?(/stopped/)
      puts instance.colorize(:red)
    else
      puts 'Every instance is running !'.colorize(:green)
    end
  end

  def server_details(options)
    # Get the id of the options
    raise InvalidKey unless options.key?('id')

    id = options[options.keys.first]
    instance = `scw instance server get #{id}`
    if instance.match?(/\d+/)
      puts instance
    else
      puts 'No results found'.colorize(:red)
    end
  rescue InvalidKey => e
    puts "[#{e.class}] - #{e.message}".colorize(:red)
  end
end
