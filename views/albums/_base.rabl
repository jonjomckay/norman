extends 'albums/_show'
attributes :mbid
node(:genres, :if => lambda { |m| !m.genres.empty? }) do |a|
  a.genres.map { |m| partial 'genres/_show', :object => m }
end
node :tracks do |a|
  a.tracks.map do |t|
    {
        :id => t.id,
        :name => t.name,
        :number => t.number,
        :duration => t.duration
    }
  end
end