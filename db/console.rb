require('pry')
require_relative('../models/album')
require_relative('../models/artist')


artist1 = Artist.new({
  'name' => 'Eugene'
  })

  artist1.save()

artist2 = Artist.new({
  'name' => 'Zsolt'
  })

album1 = Album.new({
  'title' => 'Album 1',
  'genre' => 'rock',
  'artist_id' => artist1.id
  })

album2 = Album.new({
  'title' => 'Album 2',
  'genre' => 'triphop',
  'artist_id' => artist1.id
  })




binding.pry
nil
