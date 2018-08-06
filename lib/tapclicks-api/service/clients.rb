module TapclicksApi
  class Clients < TapclicksApi::Model
    def service_url
      "https://api.tapclicks.com/v2/clients"
    end

    def create_update(params={})
      url = "http://#{@custom_domain}/app/dash/client/update_client/key/988f5f9f1dddd0c400c1d238dacf184a"
      response = request(:post, url, params, true, false)
      model = JSON.parse(response.body)
      if !model["data"]["id"].nil? && model["status"]["success"]
        return model["data"]["id"]
      else
        raise model["data"].join(",")
      end
    end

  end
end
