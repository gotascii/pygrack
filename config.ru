require 'pygrack'

map "/" do
  use Pygrack
  run Rack::Directory.new("./public")
end