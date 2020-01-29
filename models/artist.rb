require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i() if options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists
    (name) VALUES ($1) RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i()
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    albums_by_artist = results.map {|result| Album.new(result)}
    return albums_by_artist
  end

  def update()
    sql = "UPDATE artists SET (name) = ($1) WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results_array = SqlRunner.run(sql, values)
    artist_hash = results_array[0]
    found_artist = Artist.new(artist_hash)
    return found_artist
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { |artist| Artist.new(artist)}
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    artists = SqlRunner.run(sql)
  end


end
