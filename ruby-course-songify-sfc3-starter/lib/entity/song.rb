module Songify
  class Song
    attr_reader :title, :artist, :length
    def initialize(params)
      @title = params[:title]
      @artist = params[:artist]
      @length = params[:length]
    end  

  end  
end  