class Track
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  field :name
  slug :name
  field :mbid
  field :disc
  field :number
  field :duration, type: Integer
  field :year, type: Integer
  field :filename

  default_scope order_by(:number => :asc)

  belongs_to :artist
  belongs_to :album
  has_and_belongs_to_many :hashtags, inverse_of: nil
  #embeds_many :composers
  has_and_belongs_to_many :featured_artists, class_name: 'Artist', inverse_of: nil
  has_and_belongs_to_many :composers, class_name: 'Artist', inverse_of: nil
  has_and_belongs_to_many :producers, class_name: 'Artist', inverse_of: nil
  has_many :playlist_tracks
  has_many :now_playings
end
