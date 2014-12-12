module Songify::Repos
  class Playlist <Repos

    def create_table
      command = <<-SQL
        CREATE TABLE if not exists playlists(
          id SERIAL PRIMARY KEY,
          name text,
          description text
        );
      SQL
    end  

    def drop_table
      command = <<-SQL
        DROP TABLE if exists playlists
      SQL
    end  

    
    # SELECT s.title FROM songs s, p_songs j, playlist p
    #   WHERE s.id = j.song_id AND j.playlist_id = j.id
  end
end    