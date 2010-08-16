# myapp.rb
  require 'rubygems'
  require 'sinatra'
  require 'twitter_oauth'
  
  before do
    @client = TwitterOAuth::Client.new 
  end
  
  
  get '/' do
    @msg = @client.show('chgamenight')['status']['text']
    if @msg.include? "#gameon"
      @gameon = true
    end  
    @date = @client.show('chgamenight')['status']['created_at'].split[0..3].join(' ')
    erb :home
  end