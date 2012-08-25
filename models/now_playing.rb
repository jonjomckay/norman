class NowPlaying
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Orderable

  default_scope order_by(:position => :asc)

  belongs_to :track

  orderable
end
