module Songify
  def self.album_repo
    @album_repo
  end

  def self.album_repo=(repo)
    @album_repo = repo
  end  

  def self.song_repo
    @song_repo
  end   

  def self.song_repo=(repo)
    @song_repo = repo
  end
    
  module Repos
  end
end
  
require_relative './entity/playlist.rb'
require_relative './entity/album.rb'
require_relative './entity/song.rb'
require_relative './repos/repo.rb'
require_relative './repos/AlbumRepo.rb'
require_relative './repos/SongRepo.rb'

Songify.album_repo = Songify::Repos::Albums.new
Songify.song_repo = Songify::Repos::Songs.new