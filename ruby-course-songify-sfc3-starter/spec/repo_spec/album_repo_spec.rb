require_relative '../spec_helper.rb'

describe Songify::Repos::Albums do
  let(:albums){ Songify::Repos::Albums.new }
  before(:each){
    albums.drop_table
    albums.create_table
  }

  describe 'create and find_by' do
    it 'adds a new album to the album list' do
      lonelyisland = albums.create({
        title: 'Incredibad',
        year: 2009,
        genre: 'rap',
        link: 'link.jpg'
      }) 
      expect(lonelyisland).to be_a(Songify::Album)
      expect(lonelyisland.title).to eq('Incredibad')
    end 

    it 'retrieves an existing album' do
      albums.create({
          title: 'Marshal Mathers LP',
          year: 2000,
          genre: 'rap',
          link: 'album_cover.jpg'
        });
      marshal = albums.find_by({title: 'Marshal Mathers LP'})
      year = albums.find_by({genre: 'rap'})
      expect(marshal).to be_a(Songify::Album)
      expect(marshal.year).to eq(2000)
      expect(year.link).to eq('album_cover.jpg')
    end 
  end 

  describe 'update' do
    it 'changes tile, genre, or image link' do
      albums.create({
        title: 'Incredibad',
        year: 2009,
        genre: 'rap',
        link: 'link.jpg'
      }) 
      lonely = albums.update(title: 'Lonely Island', genre: 'rap')
      expect(lonely).to be_a(Songify::Album)
      expect(lonely.title).to eq('Lonely Island')
    end  
  end 

  describe 'get all' do
    it 'retrieves all albums from the database' do
      albums.create({
        title: 'Incredibad',
        year: 2009,
        genre: 'rap',
        link: 'link.jpg'
      })
      albums.create({
        title: 'Babel',
        year: 2013,
        genre: 'folk',
        link: 'link.jg'
      })
      all = albums.get_all
      expect(all.length).to eq(2)
      expect(all[0]).to be_a(Songify::Album)
    end  
  end  
end