attributes :id, :name, :description
node :autoplaylist do |i|
  !!i.is_autoplaylist
end
node :tracks, :if => lambda { |i| @display_total } do |i|
  i.tracks.count
end