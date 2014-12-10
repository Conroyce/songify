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
        VALUES ($1,$2,$3,$4)
        RETURNING *;
      SQL
      result = @db.exec(command,[title,year,genre,link])
    end  

    def build_album(params)
      title = params["title"]
      year = params["year"].to_i
      genre = params["genre"]
      link = params["link"]
      Songify::AddAlbum.new({
        title: title,
        year: year,
        genre: genre,
        link: link
      })
    end  

  end  
end  