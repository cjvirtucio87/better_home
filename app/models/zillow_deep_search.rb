# Most likely to be used for presenting in View.
class ZillowDeepSearch
  attr_reader :options, :results

  include HTTParty
  base_uri "www.zillow.com/"
  ZWSID = Rails.application.secrets.zillow_zwsid

  def initialize
    @options = { query: { 'zws-id' => ZWSID } }
    @street_address
    @city
    @state

    # zip is optional
    @zip
  end

  # Setters.
  def street_address=(address)
    @street_address = address
  end

  def city=(city)
    @city = city
  end

  def state=(state)
    @state = state
  end

  def zip=(zip)
    @zip = zip
  end

  # Preparing the options hash.
  def prep_query
    @options[:query][:address] = @street_address
    @options[:query][:citystatezip] = "#{@city} #{@state}"
    if @zip
      @options[:query][:citystatezip] += " #{@zip}"
    end
    @options
  end

  def search
    @results = self.class.get("/webservice/GetDeepSearchResults.htm", @options)
  end

  def parsed_results
    @parsed_results ||= @results.parsed_response['searchresults']['response']['results']['result']
  end

  def coords
    address = @parsed_results['address']
    @coords ||= { lat: address['latitude'], lon: address['longitude'] }
  end


end