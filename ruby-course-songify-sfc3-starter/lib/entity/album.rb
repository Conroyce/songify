module Songify
  class Album
    attr_accessor :link, :genre, :title
    attr_reader :year
    def initialize(params)
      @title = params[:title]
      @year = params[:year]
      @genre = params[:genre]
      @link = params[:link]
    end  
  end
end      