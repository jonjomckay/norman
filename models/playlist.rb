class Playlist
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  attr_accessible :name, :description, :is_autoplaylist, :tracks, :track_ids

  validates_presence_of :name

  validates_uniqueness_of :name

  field :name, :type => String
  slug :name
  field :description, :type => String
  field :is_autoplaylist, :type => Boolean

  #embeds_many :playlist_tracks, :class_name => 'PlaylistTrack'
  has_many :tracks, :class_name => 'PlaylistTrack'
end
