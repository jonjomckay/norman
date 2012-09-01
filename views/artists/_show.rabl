extends 'artists/_base'
attributes :mbid
node(:image, :if => lambda { |m| !m.images.empty? }) do |i|
  {
      :huge => i.images[0].image.url,
      :hd => i.images[0].image.thumb('1920x1080#n').url,
      :large => i.images[0].image.thumb('700x400#n').url,
      :medium => i.images[0].image.thumb('300x200#n').url,
      :tiny => i.images[0].image.thumb('75x75#n').url
  }
end
node(:albums) do |i|
  i.albums.count
end
node(:tracks) do |i|
  i.tracks.count
end
node(:real_name, :if => lambda { |m| m.real_name }) do |a|
  a.real_name
end
node(:disambiguation, :if => lambda { |m| m.disambiguation }) do |a|
  a.disambiguation
end
node(:youtube, :if => lambda { |m| m.youtube }) do |i|
  { :channel => i.youtube, :url => 'http://www.youtube.com/' + i.youtube  }
end
node(:similar, :if => lambda { |m| !m.similar_artists.empty? }) do |a|
  a.similar_artists.to_a.map { |m| partial 'artists/_base', :object => m }
end
node(:hashtags, :if => lambda { |m| !m.hashtags.empty? }) do |a|
  a.hashtags.to_a.map { |m| { :name => m.name } }
end