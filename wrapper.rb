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
    instance = `scw instance server list`.gsub(/ +/, ' ').split("\n")
    i = 0
    instance.each do |line|
      if i.zero?
        puts line.colorize(:blue)
      else
        puts "----------------- \nServer #{i} - " + line
      end
      i += 1
    end
  end

  def get(options)
    list and return if options.empty?

    get_server(options['id']) if options.key?('id')

    search = ''
    options.each do |option|
      search += "#{option[0].gsub('_', '-')}=#{option[1]} " if option[0] != 'id'
    end

    instance = `scw instance server list #{search}`
    # If instance contains only letters, it means that the search didn't return any results
    raise NoResultError unless instance.match?(/\d+/)

    puts print_instance(options, instance)
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

  def important
    # code here
  end

  def get_server(id)
    list = `scw instance server list`.split("\n")
    list.each do |line|
      return line.gsub(/ +/, ' | ') if line.split(' ')[0] == id
    end
    # No results found colorized in red !important
    'None'
  end

  def print_instance(options, instance)
    if options.key?('id')
      if options.length > 1
        instance.colorize(:green) if instance.colorize(:green).include?(get_server(options['id']).split(' ')[0])
      else
        return 'No results found'.colorize(:red) if get_server(options['id']) == 'None'

        get_server(options['id']).colorize(:green)
      end
    else
      instance.colorize(:green)
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
