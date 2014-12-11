module Songify::Repos 
  class Albums < Repo
    #CRUD: create,read,update,delete
    def create_table
      command = <<-SQL
        CREATE TABLE if not exists albums(
          id SERIAL PRIMARY KEY,
          title text,
          year integer,
          genre text,
          link text
        );
      SQL
      @db.exec(command)
    end  

    def drop_table
      command = <<-SQL
        DROP TABLE if exists albums
      SQL
      @db.exec(command)
    end 
  
    def create(params)
      title = params[:title]
      year = params[:year]
      genre = params[:genre]
      link = params[:link]
      command = <<-SQL
        INSERT INTO albums(title,year,genre,link)
        VALUES ('#{title}','#{year}','#{genre}','#{link}')
        RETURNING *;
      SQL
      result = @db.exec(command)
      build_album(result.first)
    end  

    def find_by(params)
      title = params[:title]
      year = params[:year]
      genre = params[:genre]
      if title
        command = <<-SQL
          SELECT * FROM albums WHERE title = '#{title}'
        SQL
      elsif year
        command = <<-SQL
          SELECT * FROM albums WHERE year = '#{year}'
        SQL
      elsif genre
        command = <<-SQL
          SELECT * FROM albums WHERE genre = '#{genre}'
        SQL
      end  
      result = @db.exec(command)
      build_album(result.first)
    end

    def update(params)
      title = params[:title]
      genre = params[:genre]
      link = params[:link]
      command = <<-SQL
        UPDATE albums
        SET title = '#{title}'
        WHERE genre = '#{genre}'
        RETURNING *;
      SQL
      result = @db.exec(command)
      build_album(result.first)
    end  

    def get_all
      command = <<-SQL
      SELECT * FROM albums 
      SQL
      result = @db.exec(command)
      result.map { |x| build_album(x) }
    end

    def build_album(params)
      title = params["title"]
      year = params["year"].to_i
      genre = params["genre"]
      link = params["link"]
      Songify::Album.new({
        title: title,
        year: year,
        genre: genre,
        link: link
      })
    end   
  end  
end  