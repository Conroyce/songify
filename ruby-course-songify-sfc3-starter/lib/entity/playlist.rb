module Songify
  class Playlist
    attr_reader :id
    attr_accessor :description, :name
    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @description = params[:description]
    end  
  end  
end  