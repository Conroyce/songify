module Songify::Repos
  class Playlists < Repo

    def create_table
      command = <<-SQL
        CREATE TABLE if not exists playlists(
          id SERIAL PRIMARY KEY,
          name text,
          description text
        );
      SQL
      @db.exec(command)
    end  

    def drop_table
      command = <<-SQL
        DROP TABLE if exists playlists
      SQL
      @db.exec(command)
    end  

    def create(params)
      name = params[:name]
      description = params[:description]
      command = <<-SQL
        INSERT INTO playlists(name,description)
        VALUES ('#{name}','#{description}')
        RETURNING *;
      SQL
      result = @db.exec(command)
      build_playlist(result.first)
    end 
    

    def update(params)
      name = params[:name]
      description = params[:description]
      command = <<-SQL
        UPDATE playlists
        SET name = '#{name}'
        WHERE description = '#{description}'
        RETURNING *;
      SQL
      result = @db.exec(command)
      build_playlist(result.first)
    end  

    def get_playlist_songs(params)#(playlist_id)
      name = params[:name]
      description = params[:description]
      song_id = params[:id]
      album_id = params[:almbum_id]
      command = <<-SQL
        SELECT s.title FROM songs s, p_songs j, playlist p
        WHERE s.id = j.song_id AND j.playlist_id = j.id
      SQL
      result = @db.exec(command)
    end  

    def find_by(params)
      name = params[:name]
      description = params[:description]
      if name 
        command = <<-SQL
          SELECT * FROM playlists WHERE name = '#{name}'
        SQL
      elsif description
        command = <<-SQL
          SELECT * FROM playlists WHERE description = '#{description}'
        SQL
      end 
      result = @db.exec(command)
      build_playlist(result.first) 
    end  

    def build_playlist(params)
      id = params["id"]
      name = params["name"]
      description = params["description"]
      Songify::Playlist.new({
        id: id,
        name: name,
        description: description
      })
    end  
  end
end    