module Songify::Repos
  class Songs < Repo

    def create_table
      command = <<-SQL
        CREATE TABLE if not exists songs(
          id SERIAL PRIMARY KEY,
          title text,
          artist text,
          link text,
          album_id integer REFERENCES albums(id)
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
      album_id = params[:album_id]
      # id = get_album_id(albumId)
      command = <<-SQL
        INSERT INTO songs(title,artist,link,album_id)
        VALUES ('#{title}','#{artist}','#{link}','#{album_id}')
        RETURNING *;
      SQL
      result = @db.exec(command)
      build_song(result.first)
    end 

    def get_album_id(album)
      album = album.title if album.class = Songify::Album
      album_obj = Songify::Repos::Albums.find_by({
        title: album
      }).first
      album_obj = Songify::Repos::Albums.create({
        title: album
      }) if !album_obj
      album_obj.id
    end  

    # def get_breed_id(breed)
    #   breed = breed.name if breed.class == PuppyBreeder::Breed
    #   breed_obj = PuppyBreeder.breeds_repo.find_by({
    #     name: breed
    #   }).first
    #   breed_obj = PuppyBreeder.breeds_repo.create({
    #     name: breed
    #   }) if !breed_obj
    #   breed_obj.id
    # end

    def find_by(params)
      title = params[:title]
      artist = params[:artist]
      link = params[:link]
      album_id = params[:album_id].to_i
      if title
        command = <<-SQL
          SELECT * FROM songs WHERE title = '#{title}'
        SQL
      elsif artist
        command = <<-SQL
          SELECT * FROM songs WHERE artist = '#{artist}'
        SQL
      elsif link
        command = <<-SQL
          SELECT * FROM songs WHERE link = '#{link}'
        SQL
      elsif album_id
        command = <<-SQL
          SELECT * FROM songs WHERE albumId = '#{album_id}'
        SQL
      end
      result = @db.exec(command)
      build_song(result.first)
    end  

    def update(params)
      title = params[:title]
      artist = params[:artist]
      link = params[:link]
      command = <<-SQL
        UPDATE songs
        SET title = '#{title}'
        WHERE artist = '#{artist}'
        RETURNING *;
      SQL
      result = @db.exec(command)
      build_song(result.first)
    end  

    def get_all_songs(id)
      id = id.to_i
      command = <<-SQL
        SELECT * FROM songs WHERE album_id = '#{id}'
      SQL
      result = @db.exec(command)
      result.map { |x| build_song(x) }
    end  

    def build_song(params)
      title = params['title']
      artist = params['artist']
      link = params['link']
    
      album_id = Songify.album_repo.find_by({id: params['album_id']})
     
      Songify::Song.new({
        title: title,
        artist: artist,
        link: link,
        album_id: album_id.id.to_i
      })
    end
  end  
end    