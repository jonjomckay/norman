attributes :id, :name, :slug, :year
node(:artist) do |m|
  partial 'artists/_base', :object => m.artist
end
node(:image, :if => lambda { |m| m.image }) do |i|
  {
      :huge => i.image.image.url,
      :large => i.image.image.thumb('500x500#').url,
      :medium => i.image.image.thumb('300x300#').url,
      :tiny => i.image.image.thumb('75x75#n').url
  }
end