require_relative '../spec_helper.rb'

describe Songify::Playlist do
  let(:playlist){ Songify::Playlist.new({
    name: 'playlist-1',
    description: 'best playlist ever'
  }) }

  describe 'initialize' do
    it 'will create an instance of a playlist' do
      expect(playlist).to be_a(Songify::Playlist)
      expect(playlist.name).to eq("playlist-1")
      expect(playlist.description).to eq("best playlist ever")
    end  
  end  
end