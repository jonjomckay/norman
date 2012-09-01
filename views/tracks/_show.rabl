extends 'tracks/_base'
attributes :mbid, :filename
node(:album) do |m|
  partial 'albums/_show', :object => m.album
end
node(:composers, :if => lambda { |m| !m.composers.empty? }) do |c|
  c.composers.map { |m| { :name => m.real_name } }
end
node(:producers, :if => lambda { |m| !m.producers.empty? }) do |c|
  c.producers.map { |m| { :name => m.real_name } }
end
node(:hashtags, :if => lambda { |m| !m.hashtags.empty? }) do |a|
  a.hashtags.map { |m| { :name => m.name } }
end
