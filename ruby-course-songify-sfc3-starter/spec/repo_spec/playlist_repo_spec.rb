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
end  