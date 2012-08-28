attributes :id, :name, :slug, :mbid, :number, :duration, :year, :filename
node :artist do |c|
  partial 'tracks/_artists', :object => c
end