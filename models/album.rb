require('pg')
require_relative('../db/sql_runner')

class Album

  attr_reader :id, :title, :genre, :artist_id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i()
  end


  def save()
    sql = "INSERT INTO albums
    (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @artist_id]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i()
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artist_result = results[0]
    artist = Artist.new(artist_result)
    return artist
  end

  def update()
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results_array = SqlRunner.run(sql, values)
    album_hash = results_array[0]
    found_album = Album.new(album_hash)
    return found_album
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album)}
  end


  def self.delete_all()
    sql = "DELETE FROM albums"
    albums = SqlRunner.run(sql)
  end


end
