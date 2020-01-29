require('pry')
require_relative('../models/album')
require_relative('../models/artist')


Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'name' => 'Eugene'
  })

  artist1.save()

artist2 = Artist.new({
  'name' => 'Zsolt'
  })

  artist2.save()

album1 = Album.new({
  'title' => 'Album 1',
  'genre' => 'rock',
  'artist_id' => artist1.id
  })

  album1.save()

album2 = Album.new({
  'title' => 'Album 2',
  'genre' => 'triphop',
  'artist_id' => artist2.id
  })

  album2.update()
  album2.save()



binding.pry
nil
