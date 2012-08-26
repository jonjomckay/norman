object false => :error

node :message do
  "Bad request/malformed syntax"
end
node(:errors, :if => lambda { |m| defined? @error }) do
  @error.document.errors.full_messages
end
node :code do
  400
end