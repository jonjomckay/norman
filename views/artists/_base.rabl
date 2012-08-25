extends 'artists/_show'
attributes :mbid
node(:youtube, :if => lambda { |m| m.youtube }) do |i|
    { :channel => i.youtube, :url => 'http://www.youtube.com/' + i.youtube  }
end
node(:similar, :if => lambda { |m| !m.similar_artists.empty? }) do |a|
    a.similar_artists.to_a.map { |m| partial 'artists/_show', :object => m }
end
node(:hashtags, :if => lambda { |m| !m.hashtags.empty? }) do |a|
    a.hashtags.to_a.map { |m| { :name => m.name } }
end
