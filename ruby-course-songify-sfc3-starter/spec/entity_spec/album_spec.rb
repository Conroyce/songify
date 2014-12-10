require_relative '../spec_helper.rb'

describe Songify::AddAlbum do 
  let(:eminem){ Songify::AddAlbum.new({
      title: 'Marshal Mathers LP',
      year: 2000,
      genre: 'rap',
      link: 'album_cover.jpg'
    }) 
  }

  describe 'initialize' do
    it 'creates a new instance of Eminem' do
      expect(eminem).to be_a(Songify::AddAlbum)
      expect(eminem.title).to eq('Marshal Mathers LP')
      expect(eminem.year).to eq(2000)
      expect(eminem.genre).to eq('rap')
      expect(eminem.link).to eq('album_cover.jpg')
    end  
  end  
end
