attributes :id, :position
node(:track) do |n|
  partial 'tracks/_show', :object => n.track
end
node :added do |n|
  n.created_at
end