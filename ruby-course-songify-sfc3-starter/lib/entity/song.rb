module Songify
  class Song
    attr_reader :title, :artist, :link, :album_id, :id
    def initialize(params)
      @id = params[:id]
      @title = params[:title]
      @artist = params[:artist]
      @link = params[:link]
      @album_id = params[:album_id]
    end  

  end  
end  