module ProductAPI
  require 'net/http'
  require 'json'

  # Strips wrapping JavaScript function from JSONP response,
  # returns only the JSON string contained within
  #
  # params
  #   JSONP string
  def self.format_JSONP(data)
    # Strip out leading "callbackFunction(" and trailing ");" from the JSONP string
    json = data.gsub(/\A\w+\(|\);\z/, '')

    return json
  end

  # Makes GET request to Paat's product api, formats the JSONP response
  # by stripping the JavaScript function and returns an array of the respose data
  #
  # params
  #   none
  def self.fetch_products
    # IBM Cloud Lab's product api is currently accessible through port 3002
    # on 50.97.56.226 (Paat's personal site) at the "/products/api" endpoint
    jsonp = Net::HTTP.get('50.97.56.226', '/products/api', 3002)

    # By default, the API wraps its response in a JSONP callback function
    # that must be stripped before we are able to make use of it in Ruby
    json  = ProductAPI.format_JSONP(jsonp)
    array = JSON.parse(json)

    return array
  end
  
  # Returns a formatted HTML class from an English-readable product name 
  #
  # params
  #   string, english readable (e.g. "IBM Bluemix Partner Services")
  #
  # returns
  #   string, valid HTML class (e.g. "ibm-bluemix-partner-services")
  def self.build_class(string)
    html_class = string.downcase.split(' ').join('-')

    return html_class
  end
end
