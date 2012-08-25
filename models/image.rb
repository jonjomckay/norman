class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :image_uid, type: String
  field :image_width, type: Integer
  field :image_height, type: Integer
  image_accessor :image

  default_scope order_by(:created_at => :desc).limit(3)

  embedded_in :artist
  embedded_in :album
end
