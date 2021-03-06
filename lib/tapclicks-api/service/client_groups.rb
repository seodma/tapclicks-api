module TapclicksApi
  class ClientGroups < TapclicksApi::Model
    def initialize(options={})
      @app_domain = options[:app_domain]
      super
    end
    def service_url
      "https://api.tapclicks.com/v2/clientgroups"
    end
    # client group will be updated if client_group_id passed
    def create_update(params={})
      url = "http://#{@custom_domain}/app/dash/clientGroup/update_client_group/key/988f5f9f1dddd0c400c1d238dacf184a"
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
