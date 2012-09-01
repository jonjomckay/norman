extends 'playlists/_base'
node :tracks do |a|
  a.tracks.map do |t|
    partial("tracks/_base", :object => t.track)
  end
end