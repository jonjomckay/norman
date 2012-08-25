class Genre
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  field :name
  slug :name

  index "name", unique: true

  def artists
    Artist.any_in(genre_ids: [[self[:id]]])
  end

  def albums
    Album.any_in(genre_ids: [[self[:id]]])
  end

  def tracks
    Track.any_in(genre_ids: [[self[:id]]])
  end
end
