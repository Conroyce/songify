require_relative '../spec_helper.rb'

describe Songify::Repos::Songs do
  let(:song){ Songify::Repos::Songs.new }
  let(:album){ Songify::Repos::Albums.new }
  before(:each){
    song.drop_table
    song.create_table
  }
  
  describe 'create' do
    it 'adds a new song to the song list' do
      albums = album.create({
        title: 'Waking Up',
        year: 2009,
        genre: 'Pop',
        link: 'link.jpg'
        })
      songs = song.create({
        title: 'Secrets',
        artist: 'OneRepublic',
        link: 'youtube.com',
        albumId: 1
        })
      expect(songs).to be_a(Songify::Song)
      expect(songs.title).to eq('Secrets')
    end  
  end 

  describe 'find_by' do
    it 'will retrieve a specific song' do
      song.create({
        title: 'Secrets',
        artist: 'OneRepublic',
        link: 'youtube.com',
        albumId: 1
      })
      songs = song.find_by({title: 'Secrets'})
      expect(songs).to be_a(Songify::Song)
      expect(songs.artist).to eq('OneRepublic')
    end  
  end 
end