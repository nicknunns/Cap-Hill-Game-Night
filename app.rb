# myapp.rb
  require 'rubygems'
  require 'sinatra'
  require 'twitter_oauth'
  
  before do
    @client = TwitterOAuth::Client.new 
  end
  
  
  get '/' do
    @msg = @client.show('chgamenight')['status']['text']
    @date = @client.show('chgamenight')['status']['created_at'].split[0..3].join(' ')
    @gameon = true
    erb :home
  end