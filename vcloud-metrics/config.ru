require 'rack/lobster'
require 'vcloud-metrics.rb'

map '/health' do
  health = proc do |env|
    [200, { "Content-Type" => "text/html" }, ["1"]]
  end
  run health
end

map '/lobster' do
  run Rack::Lobster.new
end

map '/' do
  welcome = proc do |env|
    [200, { "Content-Type" => "text/html" }, [<<WELCOME_CONTENTS
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Welcome to vCloud Metrics Portal</title>
</head>
<body>
<h1>Welcome to your vCloud Metrics Portal</h1>

</body>
</html>
WELCOME_CONTENTS
    ]]
  end
  run welcome
end