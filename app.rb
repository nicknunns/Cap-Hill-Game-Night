# myapp.rb
  require 'rubygems'
  require 'sinatra'
  require 'twitter_oauth'
  
  before do
    @client = TwitterOAuth::Client.new 
  end
  
  
  get '/' do
    @msg = @client.show('chgamenight')['status']['text']
    @date = @client.show('chgamenight')['status']['created_at']
    erb :home
  end