#!/usr/bin/env ruby
#

require 'rest-client'
require 'XmlSimple'
require 'json'

begin
  vcloud_session = RestClient::Resource.new("https://#{ENV['VCD_API_HOST']}/api/sessions", 
                                            "#{ENV['VCD_USERNAME']}@#{ENV['VCD_ORG']}", 
                                            ENV['VCD_PASSWORD'])
  auth = vcloud_session.post '', :accept => 'application/*+xml;version=5.6'
  auth_token = auth.headers[:x_vcloud_authorization]
rescue => e
  puts e.response
end

begin
  response = RestClient.get "https://#{ENV['VCD_API_HOST']}/api/query",
                            :params => { :type => 'vm' },
                            'x-vcloud-authorization' => auth_token,
                            :accept => 'application/*+xml;version=5.6'
rescue => e
  puts e.response
end

parsed = XmlSimple.xml_in(response.to_str)

# puts parsed.to_json
parsed['VMRecord'].each do |vm|

  if vm['catalogName'].nil?
    # puts vm.to_json

    begin
      response = RestClient.get "#{vm['href']}/metrics/current",
                                'x-vcloud-authorization' => auth_token,
                                :accept => 'application/*+xml;version=5.6'
    rescue => e
      puts e.response
    end
    stats = XmlSimple.xml_in(response.to_str)
    puts stats.to_json

  end

end