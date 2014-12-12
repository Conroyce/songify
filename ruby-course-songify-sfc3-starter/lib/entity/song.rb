module Songify
  class Song
    attr_reader :title, :artist, :link, :albumId, :id
    def initialize(params)
      @id = params[:id]
      @title = params[:title]
      @artist = params[:artist]
      @link = params[:link]
      @albumId = params[:albumId]
    end  

  end  
end  