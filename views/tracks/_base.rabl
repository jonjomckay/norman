attributes :id, :name, :slug, :track_number, :duration, :year
node :artist do |c|
  partial 'tracks/_artists', :object => c
end
node :album do |c|
  partial 'albums/_base', :object => c.album
end