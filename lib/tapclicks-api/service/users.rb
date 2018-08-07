module TapclicksApi
  class Users < TapclicksApi::Model
    def service_url
      "https://api.tapclicks.com/v2/users"
    end

    def create_update(params={})
      url = "http://#{@custom_domain}/app/dash/user/update_user/key/bd990f3b550abd09d47969c5f537782f"
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
