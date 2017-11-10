module TapclicksApi
  class Clusters < TapclicksApi::Model
    undef_method :create
    def service_url
      "https://api.tapclicks.com/v2/clusters"
    end
  end
end
