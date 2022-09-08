# frozen_string_literal: true


class IncorrectParameter < StandardError
  def initialize(msg = "Error: Incorrect parameter format, please make a parameter that follows KEY:VALUE")
    super
  end
end
class InvalidKey < StandardError
  def initialize(msg = "Error: Incorrect parameter selected, it must be ID, IP or NAME")
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
    begin
      # raise IncorrectParameter unless param.include?(':')
      # key, value = param.downcase.split(':')

      # TODO: Be able to give multiple options
      search = "#{options.keys.first}=#{options[options.keys.first]}"

      instance = `scw instance server list #{search}`
      if instance.empty?
        puts 'No results found'
      else
        puts instance
      end
    rescue IncorrectParameter => e
      # output: red
      puts "[#{e.class}] - #{e.message}"
    rescue InvalidKey => e
      # output: yellow
      puts "[#{e.class}] - #{e.message}"
    end
  end
end
