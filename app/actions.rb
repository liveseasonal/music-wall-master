# require 'pry'

before do
  @current_user = User.find(session[:user_id]) if session[:user_id]
  cookies[:page_views] ? cookies[:page_views] = cookies[:page_views].to_i + 1 : cookies[:page_views] = 1
end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end  

get '/songs/new' do
  erb :'songs/new'
end 

post '/songs' do 
  # binding.pry
  @song = Song.new(
    song_title: params[:song_title],
    author: params[:author],
    URL: params[:URL]
    )

  if @song.save
    redirect '/songs'
  else
    erb :'songs/new' 
  end   
end


# Show the login form
get '/login' do
  erb :login
end

#Do I need to make a couple of users????
post '/login' do
  # binding.pry
  user = User.find_by(email: params[:email])
  if user.password == params[:password]
    session[:user_id] = user.id
    # session[:poem] = "Red roses are best in Feb"
    #TODO flash successful login
    redirect '/'
  else
    #TODO flash a message
    redirect "/"
  end
end

#logout

get '/logout' do
  session.clear
  #TODO flash message
  redirect '/'
end

#Signup

get '/signup' do 
  erb :signup
end  

#Its an action So for the below we have specified in the signup.erb that we will perform the action below.

post '/user/create' do 
  # binding.pry
 
  @user = User.new(
    email: params[:email],
    password: params[:password],
    )

  if @user.save
    redirect '/login'
  else
    erb :index
    puts "Failed" 
  end   
end





