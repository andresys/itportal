class HttpImport1CService < ApplicationService
  include HTTParty

  class << self
    @@config = YAML.load_file(File.join('config', 'http1c.yml'))[Rails.env]
  end

  base_uri "#{@@config['protocol'] || 'http'}://#{@@config['host']}/#{@@config['database']}"
  basic_auth @@config['username'], @@config['password']
  headers 'Content-Type' => 'application/json'

  attr_reader :path, :options

  def initialize(api_path)
    @path = api_path
  end

  def call
    p "Loading data from #{@path}"
    response = self.class.get(@path, { verify: false })
    response.code == "OK" ? response : response
  end
end