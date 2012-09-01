extends 'albums/_base'
attributes :mbid
node(:genres, :if => lambda { |m| !m.genres.empty? }) do |a|
  a.genres.map { |m| partial 'genres/_base', :object => m }
end
node :tracks do |a|
  a.tracks.map do |t|
    {
        :id => t.id,
        :name => t.name,
        :track_number => t.track_number,
        :duration => t.duration
    }
  end
end