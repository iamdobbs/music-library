require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /albums'  do
    it 'should return the list of albums with links' do
      response = get('/albums')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a><br />')
      expect(response.body).to include('<a href="/albums/3">Waterloo</a><br />')
    end
  end    

  context 'GET /albums/new' do
    it 'should provide a form for new album input' do
      response = get('albums/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/albums">')
      expect(response.body).to include('input type="text" name="title"')
      expect(response.body).to include('input type="text" name="release_year"')
      expect(response.body).to include('input type="text" name="artist_id"')
    end
  end    


  context 'POST /albums' do
    it 'should create a new album' do
      response = post(
        '/albums',
        title: 'All We Know',
        release_year: '2016',
        artist_id: '2'
      )

      expect(response.status).to eq(200)
      expect(response.body).to include('New album created!')

      response = get('/albums')

      expect(response.body).to include('All We Know')
    end
  end    

  context 'GET /albums/:id' do
    it 'returns an album specified by id' do
      response = get('/albums/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end
  end

  context 'GET /artists'  do
    it 'should return the list of artists with links' do
      response = get('/artists')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/artists/1">Pixies</a><br />')
      expect(response.body).to include('<a href="/artists/2">ABBA</a><br />')
    end
  end    

  context 'GET /artists/new' do
    it 'should provide a form for new artist input' do
      response = get('artists/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/artists">')
      expect(response.body).to include('input type="text" name="name"')
      expect(response.body).to include('input type="text" name="genre"')
    end
  end   

  context 'POST /artists' do
    it 'should create a new artist' do
      response = post(
        '/artists',
        name: 'Nao',
        genre: 'RnB'
      )

      expect(response.status).to eq(200)
      expect(response.body).to include('New artist created!')

      response = get('/artists')

      expect(response.body).to include('Nao')
    end
  end   

  context 'GET /artists/:id' do
    it 'returns an artist specified by id' do
      response = get('/artists/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('Pixies')
    end
  end
end
