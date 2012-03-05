class ApiAccess < ActiveRecord::Base

  def self.gnavi_api_get params = {}
    uri = URI.parse(self.gnavi_original_url)
    uri.query = params.to_query
    self.api_request(:get, uri.to_s)
  end

  def self.geo_api_get params = {}
    uri = URI.parse(self.geo_original_url)
    uri.query = params.to_query
    self.api_request(:get, uri.to_s)
  end

private
  def self.api_request method, uri
    response = HTTParty.send method, uri
    if response.code.to_s == "200"
      Hashie::Mash.new(response)
    else
      logger.info "[Unexpected status] ResponseCode:#{response.code} Detail:#{response.inspect}"
    end
  end

  def self.gnavi_original_url
    "http://api.gnavi.co.jp/ver1/RestSearchAPI/"
  end

  def self.geo_original_url
    "http://www.geocoding.jp/api/"
  end

  def self.get_response_by_group(group, location)
    self.gnavi_api_get({:keyid => "dd0f3c4c27d1f6b371cd99acbebe97fb", :latitude => location.lat, :longitude => location.lng, :range => 1, :hit_per_page => 999, :input_coordinates_mode => 2}).response.rest
  end
end
