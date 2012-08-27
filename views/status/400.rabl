object false => :error

node :message do
  "Bad request/malformed syntax"
end
node(:info, :if => lambda { |m| defined? @error }) do
  @error.message
end
node :code do
  400
end