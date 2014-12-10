require 'pg'

module Songify::Repos
  class Repo
    def initialize
      @db = PG.connect(dbname:'songify')
    end  
  end
end   