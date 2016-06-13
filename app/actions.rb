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


