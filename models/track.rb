class Track
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  attr_accessible :name, :mbid, :disc, :track_number, :duration, :year, :filename, :image, :image_id, :artist, :artist_id, :album, :album_id, :genres, :hashtags, :featured_artists, :featured_artist_ids, :composers, :composer_ids, :producers, :producer_ids

  validates_presence_of :name, :track_number, :duration, :filename, :artist, :album

  validates_uniqueness_of :name, :scope => [:album, :mbid, :year]

  field :name
  slug :name
  field :mbid
  field :disc
  field :track_number
  field :duration, type: Integer
  field :year, type: Integer
  field :filename

  default_scope order_by(:track_number => :asc)

  belongs_to :artist
  belongs_to :album
  has_and_belongs_to_many :hashtags, inverse_of: nil
  #embeds_many :composers
  has_and_belongs_to_many :featured_artists, class_name: 'Artist', inverse_of: nil
  has_and_belongs_to_many :composers, class_name: 'Artist', inverse_of: nil
  has_and_belongs_to_many :producers, class_name: 'Artist', inverse_of: nil
  has_many :now_playings
  has_many :playlists, :class_name => 'PlaylistTrack'
end
