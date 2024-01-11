class HttpImportService < ApplicationService
  include HTTParty

  def self.config_file filename
    @@config = YAML.load_file(File.join('config', "#{filename}.yml"))[Rails.env]

    base_uri "#{@@config['protocol'] || 'http'}://#{@@config['host']}"
    basic_auth @@config['username'], @@config['password']
    headers 'Content-Type' => 'application/json'
    # headers 'X-Requested-With' => 'XMLHttpRequest'
  end

  attr_reader :path, :options

  def initialize(api_path = '')
    @path = "#{@@config['path']}/#{api_path}".gsub(/\/+/, '/').gsub(/\/+$/, '')
  end

  def call
    set_status "Loading data from #{@@config['protocol'] || 'http'}://#{@@config['host']}#{@path}"
    response = self.class.get(@path, { verify: false })
    set_status "Loading status is #{response.code}"
    response.code == "OK" ? response : response
  end
end