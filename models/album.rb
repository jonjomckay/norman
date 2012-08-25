class Album
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  attr_accessible :name, :mbid, :year, :image, :image_id, :artist, :artist_id, :tracks, :genres, :hashtags

  validates_uniqueness_of :name, :scope => [:artist, :mbid, :year]

  field :name
  slug :name
  field :mbid
  field :year, type: Integer

  embeds_one :image, validate: false
  belongs_to :artist
  has_many :tracks
  has_and_belongs_to_many :genres, inverse_of: nil
  has_and_belongs_to_many :hashtags, inverse_of: nil
end
