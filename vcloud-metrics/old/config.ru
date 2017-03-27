# require 'rack/lobster'

require_relative 'lib/vcloud'

map '/health' do
  health = proc do |env|
    [200, { "Content-Type" => "text/html" }, ["1"]]
  end
  run health
end

# map '/lobster' do
#   run Rack::Lobster.new
# end

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

To retrieve vCloud Director usage metrics in a user-friendly JSON format
suitable for indexing with Elastic Search, POST the following JSON body to:
<p>
<a href="http://#{env['HTTP_HOST']}/stats">http://#{env['HTTP_HOST']}/stats</a>
<P>
<pre>
{ "vcd_api_url": "https://${VCD_API_HOST}/api",
  "vcd_username": "${VCD_USERNAME}@${VCD_ORG}",
  "vcd_password": "${VCD_PASSWORD}" }
</pre>

Example using Curl:
<br>
<pre>
curl -X POST -d '{"vcd_api_url": "https://${VCD_API_HOST}/api","vcd_username": "${VCD_USERNAME}@${VCD_ORG}", "vcd_password": "${VCD_PASSWORD}" }' -i http://#{env['HTTP_HOST']}/stats
</pre>
</body>
</html>
WELCOME_CONTENTS
    ]]
  end
  run welcome
end