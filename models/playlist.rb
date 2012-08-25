class Playlist
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  field :name, :type => String
  slug :name
  field :description, :type => String
  field :is_autoplaylist, :type => Boolean

  has_many :playlist_tracks
end
