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

  describe 'update' do
    it 'will update title' do
      song.create({
        title: 'We Will Rock You',
        artist: 'Queen',
        link: 'youtube.com',
        albumId:1
      })
      new_title = song.update({title:'We Are The Champions', artist: 'Queen'})
      expect(new_title).to be_a(Songify::Song)
      expect(new_title.title).to eq("We Are The Champions")
    end  
  end  

  describe 'get all songs' do
    it 'will retrieve all songs with the same album id' do
      album.create({
        title: 'Cool Album',
        year: 1992,
        genre: 'Pop',
        link: 'neat.com'
      })
      song.create({
        title: 'Tubthumper',
        artist: 'Chumbawumba',
        link: 'youtube.com',
      })
      song.create({
        title: 'I will always love you',
        artist: 'Whitney Houston',
        link: 'coolvid.com'
      })
      songs = song.get_all_songs(artist: 'Chumbawumba')
      binding.pry
      expect(songs.length).to eq(2)
      expect(songs[0]).to be_a(Songify::Song)
    end  
  end  
end











