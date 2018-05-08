module TapclicksApi
  class MarginRules < TapclicksApi::Model
    def initialize(options={})
      @app_domain = options[:app_domain]
      super
    end
    def service_url
      "https://api.tapclicks.com/v2/m"
    end
    #  margine_rule will be updated if client_group_id passed
    def create_update(params={})
      url = "http://#{@custom_domain}/app/dash/margin/update_margin_rule/key/7177ef3b6ebffde2d3d27beebbff5ba8"
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
