require 'sinatra'
require 'sinatra/json'
require 'pry-byebug'
require "sinatra/reloader" if development?

require_relative 'lib/songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant

album = Songify::Repos::Albums.new

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
  puts params
  @album_page = params[:id]
  
  @message = "Songify"
  @remarks = ["Add an Album"]
  erb :album
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

 

  