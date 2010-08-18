# myapp.rb
  require 'rubygems'
  require 'sinatra'
  require 'twitter_oauth'
  
  
  configure do
    twit_uri = 'http://twitter.com/'
    search_uri = twit_uri + 'search?q=%23'
  end
  
  before do
    @client = TwitterOAuth::Client.new 
  end
  
  helpers do
    def wrap_url(msg)
      exp = Regexp.new('http\://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?')
      if msg.match(exp)
        msg.gsub!(exp) { |s| '<a href = "' + s + '">' + s + '</a>'}
      else
        msg
      end
    end

    def wrap_tag(msg)
      exp = Regexp.new('#[A-Za-z0-9-]+')
      if msg.match(exp)
        msg.gsub!(exp) { |s| '<a href = "' + search_uri + s[1..-1] + '">' + s + '</a>'}
      else
        msg
      end
    end
    
    def wrap_user(msg)
      exp = Regexp.new('@[A-Za-z0-9-]+')
      if msg.match(exp)
        msg.gsub!(exp) { |s| '<a href = "' + twit_uri + s[1..-1] + '">' + s + '</a>'}
      else
        msg
      end
    end
  end
  
  
  get '/' do
    tweet = @client.show('chgamenight')['status']['text']
    wrap_tag(tweet)
    wrap_user(tweet)
    wrap_url(tweet)
    @msg = tweet
    if @msg.include? "#gameon"
      @gameon = true
    end  
    @date = @client.show('chgamenight')['status']['created_at'].split[0..3].join(' ')
    erb :home
  end