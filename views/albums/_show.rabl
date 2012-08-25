attributes :id, :name, :slug, :mbid, :year
node(:artist) do |m|
  partial 'artists/_show', :object => m.artist
end
node(:image, :if => lambda { |m| m.image }) do |i|
  {
      :huge => {
          :width => i.image.image.width,
          :height => i.image.image.height,
          :url => i.image.image.url
      },
      :large => {
          :url => i.image.image.thumb('500x500#').url
      },
      :medium => {
          :url => i.image.image.thumb('300x300#').url
      },
      :tiny => {
          :url => i.image.image.thumb('75x75#n').url
      }
  }
end