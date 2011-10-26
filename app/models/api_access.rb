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
end
