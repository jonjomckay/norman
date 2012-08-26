attributes :id, :name, :slug, :mbid, :number, :duration, :year, :filename
node(:artist) do |c|
  {
      :name => c.artist.name,
      :featured => unless c.featured_artists.empty?
                     c.featured_artists.map { |m| { :name => m.name } }
                   end
  }
end