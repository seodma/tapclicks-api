module TapclicksApi
  class Users < TapclicksApi::Service

    SERVICE_URL = "https://api.tapclicks.com/v2/users"

    def get_users
      response = request(:get, SERVICE_URL)
      users = JSON.parse(response.body)
      return users["data"]
    end

    def create_user(params={})
      response = request(:post, SERVICE_URL, params)
      user = JSON.parse(response.body)
      if !user["data"].nil? && user["error"] == false
        return user["data"]["id"]
      else
        raise user["data"].join("; ")
      end
    end

  end
end
