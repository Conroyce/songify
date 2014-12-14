require_relative '../spec_helper.rb'

describe Songify::Repos::Playlists do 
  let(:playlist){ Songify::Repos::Playlists.new }
  before(:each){
    playlist.drop_table
    playlist.create_table
  }

  describe 'create' do
    it 'adds a new playlist' do
      play = playlist.create({
        name: 'playlist_1',
        description: 'best playlist ever'
      })
      expect(play).to be_a(Songify::Playlist)
      expect(play.name).to eq("playlist_1")
    end  
  end 

  describe 'update' do
    it 'updates name of a playlist' do
      playlist.create({
        name: 'playlist_2',
        description: '2nd best playlist ever'
      })
      play = playlist.update({
        name: 'playlist_best',
        description: '2nd best playlist ever'
        })
      expect(play).to be_a(Songify::Playlist)
      expect(play.name).to eq('playlist_best')
    end 
  end 

  describe 'find_by' do
    it 'finds a playlist by name or description' do
      playlist.create({
        name:'playlist-good',
        description: 'good playlist'
      })
    end  
  end 
end  