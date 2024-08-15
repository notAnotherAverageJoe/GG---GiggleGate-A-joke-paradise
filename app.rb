require 'sinatra/activerecord'
require 'httparty'
require 'bcrypt'
require 'json'
require './models/user'
require './models/joke'




class HiSinatra < Sinatra::Base
use Rack::MethodOverride
set :database_file, 'config/database.yml'
enable :sessions
set :session_secret, 'aaaaaa4f7d74b2d8f63c6d7e90ecac9c72d54eb26fe4b1d08ebdc05505f9b5b52c1c07'  

  before '/favorites' do
    unless session[:user_id]
      puts "Session not found; redirecting to login."  # Debugging line
      redirect '/login'
    end
  end

  JOKE_API_BASE_URL = 'https://v2.jokeapi.dev/joke/Programming?blacklistFlags=nsfw,religious,political,racist,sexist,explicit'
  JOKE_API_SPOOKY = 'https://v2.jokeapi.dev/joke/Spooky?blacklistFlags=nsfw,religious,political,racist,sexist,explicit'
  JOKE_API_PUN = 'https://v2.jokeapi.dev/joke/Pun?blacklistFlags=nsfw,religious,political,racist,sexist,explicit'
  JOKE_API_CHRISTMAS = 'https://v2.jokeapi.dev/joke/Christmas?blacklistFlags=nsfw,religious,political,racist,sexist,explicit'

  
get '/' do
  erb :index, layout: :layout
end

  get '/about' do
    erb :about, layout: :layout
  end

  get '/joke' do
    response = HTTParty.get(JOKE_API_BASE_URL)
    joke = JSON.parse(response.body)

    if joke['type'] == 'single'
      @joke_text = joke['joke']
    else
      @joke_text = "#{joke['setup']} - #{joke['delivery']}"
    end

    erb :joke, layout: :layout
  end

  get '/spooky' do
    response = HTTParty.get(JOKE_API_SPOOKY)
    joke = JSON.parse(response.body)

    if joke['type'] == 'single'
      @joke_text = joke['joke']
    else
      @joke_text = "#{joke['setup']} - #{joke['delivery']}"
    end

    erb :spooky, layout: :layout
  end

  get '/pun' do
    response = HTTParty.get(JOKE_API_PUN)
    joke = JSON.parse(response.body)

    if joke['type'] == 'single'
      @joke_text = joke['joke']
    else
      @joke_text = "#{joke['setup']} - #{joke['delivery']}"
    end

    erb :pun, layout: :layout
  end

  get '/christmas' do
    response = HTTParty.get(JOKE_API_CHRISTMAS)
    joke = JSON.parse(response.body)

    if joke['type'] == 'single'
      @joke_text = joke['joke']
    else
      @joke_text = "#{joke['setup']} - #{joke['delivery']}"
    end

    erb :christmas, layout: :layout
  end

  #----------------------------------VVVV - Favorite joke routes - VVVV---------------------------------------------#
  
  post '/favorites' do
    puts "Params: #{params.inspect}"  # Debugging line
    user = User.find(session[:user_id])
    joke = user.jokes.create(content: params[:joke])
    if joke.save
      redirect '/favorites'
    else
      puts "Error saving joke: #{joke.errors.full_messages.join(", ")}"  # Debugging line
      redirect '/favorites?error=Unable to save joke'
    end
  end
  
  get '/favorites' do
    redirect '/login' unless session[:user_id]  # Ensure user is logged in
    @user = User.find(session[:user_id])
    @jokes = @user.jokes
    erb :favorites, layout: :layout
  end

  delete '/favorites/:id' do
    user = User.find(session[:user_id])
    joke = user.jokes.find(params[:id])
    if joke.destroy
      redirect '/favorites'
    else
      redirect '/favorites?error=Unable to delete joke'
    end
  end
#------------------------------------------^^^^ Favorite joke routes ^^^^-------------------------------------------------------#{}-

  # Register route
  get '/register' do
    erb :register
  end

  post '/register' do
    user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if user.save
      redirect '/login'
    else
      redirect '/register'
    end
  end

  get '/login' do
    erb :login  
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      puts "User authenticated: #{user.id}"  # Debug
      puts "Session after login: #{session.inspect}"  # Debug
      response.set_cookie('user_id', value: user.id, path: '/', expires: Time.now + 3600)  # Set cookie manually
      redirect '/favorites'
    else
      puts "Authentication failed"  # Debug
      redirect '/login?error=Invalid username or password'
    end
  end

  # Logout route
  get '/logout' do
    session.clear
    puts "Session cleared"  # Debug
    redirect '/'
  end
end
