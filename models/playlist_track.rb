class PlaylistTrack
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Orderable

  default_scope order_by(:position => :asc)

  #embedded_in :playlist
  #belongs_to :track
  belongs_to :playlist
  belongs_to :track

  orderable :scope => :playlist
end
