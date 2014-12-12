module Songify
  class Album
    attr_accessor :link, :genre, :title, :id
    attr_reader :year
    def initialize(params)
      @id = params[:id] 
      @title = params[:title]
      @year = params[:year]
      @genre = params[:genre]
      @link = params[:link]
    end  
  end
end      