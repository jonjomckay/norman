class Composer
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  field :name
  slug :name

  embedded_in :track
end
