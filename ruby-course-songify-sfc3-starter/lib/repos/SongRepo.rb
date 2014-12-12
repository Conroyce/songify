module Songify::Repos
  class Songs < Repo

    def create_table
      command = <<-SQL
        CREATE TABLE if not exists songs(
          id SERIAL PRIMARY KEY,
          title text,
          artist text,
          link text,
          albumId integer REFERENCES albums( id )
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
      link = params[:link]
      albumId = params[:albumId]
      command = <<-SQL
        INSERT INTO songs(title,artist,link,albumId)
        VALUES ('#{title}','#{artist}','#{link}','#{albumId}')
        RETURNING *;
      SQL
      result = @db.exec(command)

      build_song(result.first)
    end  


    def build_song(params)
      title = params['title']
      artist = params['artist']
      link = params['link']
      albumId = params['albumId']
     
      Songify::Song.new({
        title: title,
        artist: artist,
        link: link,
        albumId: albumId.to_i
      })
    end
  end  
end    