class HttpImport1CService < ApplicationService
  include HTTParty
  base_uri 'https://10.10.2.31'

  attr_reader :path, :options

  def initialize(api_path)
    basic_auth = {:username => "admin", :password => "inf24!sp"}
    @options = { basic_auth: basic_auth, verify: false, headers: {'Content-Type' => 'application/json'} }
    @path = api_path
  end

  def call
    response = self.class.get(@path, @options)
    response.code == "OK" ? response : response
  end
end