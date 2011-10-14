class ApiAccess < ActiveRecord::Base

  def self.api_get params = {}
    uri = URI.parse(self.original_url)
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

  def self.original_url
    "http://api.gnavi.co.jp/ver1/RestSearchAPI/"
  end

end
