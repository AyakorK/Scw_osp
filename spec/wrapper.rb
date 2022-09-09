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

  describe 'get' do
    it 'should return an error message if the name is incorrect' do
      expect { @wrapper.get({ 'name' => 'test_name' }) }.to output(/Error: No Results Found/).to_stdout
    end
    it 'should return an error message if the private_ip is incorrect' do
      expect { @wrapper.get({ 'private_ip' => '11.11.11.11' }) }.to output(/Error: No Results Found/).to_stdout
    end
    it 'should return an error message if the private_ip is incorrect and the name is correct' do
      expect do
        @wrapper.get({ 'private_ip' => '11.11.11.11',
                       'name' => 'metabase-dev' })
      end.to output(/Error: No Results Found/).to_stdout
    end
    it 'should be equal to @wrapper.list if it get no parameters' do
      expect { @wrapper.get({}) }.to output(@wrapper.list).to_stdout
    end
    it 'should return a server if everything is correct and a result is found' do
      expect { @wrapper.get({ 'private_ip' => '10.71.46.65', 'name' => 'metabase-dev' }) }.to output.to_stdout
    end
  end

  describe 'checkup' do
    it 'should return a message if all servers are running' do
      expect { @wrapper.checkup }.to output(/Every instance is running !/).to_stdout
    end
    #     it 'should return a server if one server is stopped' do
    #       expect { @wrapper.checkup }.to output ('stopped').to_stdout if @wrapper.list =~ /stopped/
    #     end
  end

  describe 'server_details' do
    it 'should return an error message if the id is incorrect' do
      expect do
        @wrapper.server_details({ 'id' => '11111111-1111-1111-1111-111111111111' })
      end.to output(/No results found/).to_stdout
    end
    it 'should return a server if the id is correct' do
      # expect { @wrapper.server_details({"id"=>"1a0e66a4-b8c3-4d77-a3fc-9bfe96990e13"}) } to contain Project
      expect { @wrapper.server_details({ 'id' => '1a0e66a4-b8c3-4d77-a3fc-9bfe96990e1c' }) }.to output.to_stdout
    end
  end
end
