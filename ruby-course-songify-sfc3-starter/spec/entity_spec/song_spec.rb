require_relative '../spec_helper.rb'

describe Songify::Song do
  let(:song){ Songify::Song.new({
      title: 'I Kissed A Girl',
      artist: 'Katy Perry',
      link: 'youtube.com'
    }) 
  }

  describe 'initialize' do
    it 'will create an instance of katy perry' do
      expect(song).to be_a(Songify::Song)
      expect(song.title).to eq("I Kissed A Girl")
      expect(song.artist).to eq("Katy Perry")
      expect(song.link).to eq("youtube.com")
    end
  end  
end