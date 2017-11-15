module TapclicksApi
  class ClientGroups < TapclicksApi::Model
    
    def service_url
      "https://api.tapclicks.com/v2/clientgroups"
    end
    # client group will be updated if client_group_id passed
    def create_update(params={})
      url = "https://#{@@app_domain}.tapclicks.com/app/dash/clientGroup/update_client_group/key/id7pusme0j3strek7evfmbtj01alkskv"
      response = request(:post, url, params, true)
      model = JSON.parse(response.body)
      if !model["data"].nil? && model["error"] == false
        return model["data"]["id"]
      else
        return model
        raise model["data"].join("; ")
      end
    end

  end
end
