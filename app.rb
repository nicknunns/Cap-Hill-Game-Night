# myapp.rb
  require 'rubygems'
  require 'sinatra'
  require 'twitter_oauth'
  
  before do
    @client = TwitterOAuth::Client.new 
  end
  
  
  get '/' do
    @msg = @client.show('chgamenight')['status']['text']
    erb :home
  end