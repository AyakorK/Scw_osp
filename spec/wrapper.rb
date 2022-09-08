# frozen_string_literal: true

# Make a test
require 'spec_helper'
require_relative '../wrapper'

describe Wrapper do
  before do
    @wrapper = Wrapper.new
  end
  describe '#list' do
    it 'should return the list of servers' do
      expect { @wrapper.list }.to output.to_stdout
    end
  end

  describe '#scw_get' do
    it 'should return an error message if the ID is incorrect' do
      expect { @wrapper.scw_get('ID:ABCDEF') }.to output('No results found').to_stdout
    end
    it 'should return an error message if the IP is incorrect' do
      expect { @wrapper.scw_get('IP:IAZRJEZ') }.to output('No results found').to_stdout
    end
    it 'should return an error message if the NAME is incorrect' do
      expect { @wrapper.scw_get('NAME:30230120') }.to output('No results found').to_stdout
    end
    it 'should return an error message if the parameter is incorrect' do
      expect do
        @wrapper.scw_get('ABCDEF')
      end.to output('Error: Incorrect parameter format, please make a parameter that follows KEY:VALUE').to_stdout
    end
    it 'should return an error message if the parameter is empty' do
      expect do
        @wrapper.scw_get('')
      end.to output('Error: Incorrect parameter format, please make a parameter that follows KEY:VALUE').to_stdout
    end
    it 'should return a server if everything is correct and a result is found' do
      expect { @wrapper.scw_get('ID:11111111-1111-1111-1111-111111111111') }.to output.to_stdout
    end
  end
end
