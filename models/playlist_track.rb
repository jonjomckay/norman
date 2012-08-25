class PlaylistTrack
  include Mongoid::Document

  field :order, :type => Integer

  default_scope order_by(:order => :asc)

  belongs_to :playlist
  belongs_to :track
end
