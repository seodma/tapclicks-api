module TapclicksApi
  class ClientGroups < TapclicksApi::Model
    undef_method :create
    def service_url
      "https://api.tapclicks.com/v2/clientgroups"
    end
  end
end
