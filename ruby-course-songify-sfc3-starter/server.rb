require 'sinatra'
require 'sinatra/json'
require 'pry-byebug'
require "sinatra/reloader" if development?

require_relative 'lib/songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant

album = Songify::Repos::Albums.new
song = Songify::Repos::Songs.new

get '/' do
  redirect '/albums'
end  

get '/albums' do
  # puts params
  # redirect_to '/index.erb'
  @albums_arr = album.get_all
  @message = "Songify"
  @remarks = ["Add an Album"]
  erb :index
end 

get '/albums/:id' do
  @album_page = params[:id]
  @songs = song.get_all_songs(@album_page)
  @message = "Songify"
  @remarks = ["Add an Album"]
  erb :album
end 

get '/playlists' do
  @playlist_id = params[:id]
  erb :playlist
end  

post '/' do
  puts params
  title = params[:title]
  year = params[:year]
  genre = params[:genre]
  link = params[:link]

  album.create({
    title: title,
    year: year,
    genre: genre,
    link: link
  })   
end 

post '/playlists' do
  song_id = params[:id]
  album_id = params[:album_id]
end  

post '/albums/:id' do
  puts params
  title = params[:title]
  artist = params[:artist]
  link = params[:link]
  id = params["id"]

  song.create({
    title: title,
    artist: artist,
    link: link,
    album_id: id
  })
redirect "/albums/#{id}"
end 

# 1.get album id
# 2.

# post '/albums' do
#   redirect to('/albums')
# end  

# SELECT s.id, s.title 
# FROM playlist_songs ps
# JOIN songs s
# ON s.id = ps.song_id
# WHERE ps.playlist_id = 2

 

  