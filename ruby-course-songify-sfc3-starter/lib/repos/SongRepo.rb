module Songify::Repos
  class Songs < Repos

    def create_table
      command = <<-SQL
        CREATE TABLE if not exists songs(
          id SERIAL PRIMARY KEY,
          title text,
          artist text,
          length text
          );
      SQL
      @db.exec(command)
    end  

    def drop_table
      command = <<-SQL
        DROP TABLE if exists songs
      SQL
      @db.exec(command)
    end  

    def create(params)
      title = params[:title]
      artist = params[:artist]
      length = params[:length]
      command = <<-SQL
        INSERT INTO songs(title,artist,length)
        VALUES ()
      SQL
    end  
  end  
end    