attributes :id, :name, :slug, :mbid
node(:albums) do |i|
  i.albums.count
end
node(:tracks) do |i|
  i.tracks.count
end
node(:image, :if => lambda { |m| !m.images.empty? }) do |i|
  {
      :huge => i.images[0].image.url,
      :hd => i.images[0].image.thumb('1920x1080#n').url,
      :large => i.images[0].image.thumb('700x400#n').url,
      :medium => i.images[0].image.thumb('300x200#n').url,
      :tiny => i.images[0].image.thumb('75x75#n').url
  }
end