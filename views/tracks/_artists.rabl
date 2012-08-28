node do |a|
  partial 'artists/_base', :object => a.artist
end
node :featured, :if => lambda { |a| !a.featured_artists.empty? } do |c|
  c.featured_artists.map do |t|
    partial("artists/_base", :object => t)
  end
end