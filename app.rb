  require 'rubygems'
  require 'sinatra'
  require 'curb'
  require 'json'
  
  
  configure do
    Twit_uri = 'http://twitter.com/'
    Search_uri = Twit_uri + 'search?q=%23'
  end
  
  before do
    api_uri = 'http://api.twitter.com/1/statuses/user_timeline.json?screen_name='
    screen_name = 'chgamenight'
    connection = Curl::Easy.new(api_uri + screen_name)
    connection.http_get
    @result = JSON.parse(connection.body_str)
  end
  
  helpers do
    def wrap_url(msg)
      exp = Regexp.new('http\://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?')
      if msg.match(exp)
        msg.gsub!(exp) { |s| '<a href="' + s + '">' + s + '</a>'}
      else
        msg
      end
    end

    def wrap_tag(msg)
      exp = Regexp.new('#[A-Za-z0-9-]+')
      if msg.match(exp)
        msg.gsub!(exp) { |s| '<a href="' + Search_uri + s[1..-1] + '">' + s + '</a>'}
      else
        msg
      end
    end
    
    def wrap_user(msg)
      exp = Regexp.new('@[A-Za-z0-9-]+')
      if msg.match(exp)
        msg.gsub!(exp) { |s| '<a href="' + Twit_uri + s[1..-1] + '">' + s + '</a>'}
      else
        msg
      end
    end
  end
  
  
  get '/' do

    for i in 0...@result.size
      if @result[i]["text"].match('#gameon')
        tweet = @result[i]
        @gameon = true
        break
      elsif @result[i]["text"].match('#gameoff') 
        tweet = @result[i]
        break
      else
        tweet = @result[0]
      end
    end
    
    @msg = tweet["text"]
    @date = tweet['created_at'].split[0..3].join(' ')
    
    wrap_url(@msg)
    wrap_tag(@msg)
    wrap_user(@msg)
  
    erb :home
  end