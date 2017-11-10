module TapclicksApi
  class Model < TapclicksApi::Service

    def get(id=nil)
      url = id.nil? ? service_url : "#{service_url}/#{id}"
      response = request(:get, url)
      users = JSON.parse(response.body)
      return users["data"]
    end

    def create(params={})
      response = request(:post, service_url, params)
      model = JSON.parse(response.body)
      if !model["data"].nil? && model["error"] == false
        return model["data"]["id"]
      else
        raise model["data"].join("; ")
      end
    end

  end
end
