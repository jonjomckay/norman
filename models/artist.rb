class Artist
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  attr_accessible :name, :mbid, :disambiguation, :youtube, :real_name

  validates_presence_of :name

  validates_uniqueness_of :name, :scope => [:mbid, :disambiguation, :real_name]

  field :name
  slug :name
  field :mbid
  field :disambiguation
  field :youtube
  field :real_name

  embeds_many :images, validate: false
  #belongs_to :track, inverse_of: :featured_artists
  #belongs_to :track, inverse_of: :composers
  #belongs_to :track, inverse_of: :producers
  has_many :albums
  has_many :tracks
  has_and_belongs_to_many :hashtags, inverse_of: nil
  has_and_belongs_to_many :similar_artists, class_name: "Artist", inverse_of: nil

  def real_name
    super || self[:name]
  end
end
