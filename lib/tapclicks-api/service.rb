module TapclicksApi
  class Service

    BOUNDARY = "TapClicksPROOMXNTDSZXIDECPOTOKOUVUOWSIUYFCIZSAZMQNGDGPVOIHPDIGOIIN"

    def initialize(options={})
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @app_domain = options[:app_domain]
      @email = options[:email]
      @password = options[:password]
      @expires_at = nil
      refresh_token
    end

    def request(method, url, params={}, use_cookies=false)
      headers = ( { Authorization: "Bearer #{@access_token}" } ) if !@access_token.nil?
      uri = URI.parse(url)

      case method
      when :get
          request = Net::HTTP::Get.new uri
          request['Authorization'] =  @access_token
          response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          http.request request
        end
        response.body
      when :post
        post_body = []
        post_body << "--#{BOUNDARY}\r\n"
        post_body << "Content-Disposition: form-data; name=\"model\"\r\n\r\n"
        post_body << params.to_json
        post_body << "\r\n\r\n--#{BOUNDARY}--\r\n"
        request = Net::HTTP::Post.new(uri)
        request.body = post_body.join
        request['Content-Type'] = "multipart/form-data, boundary=#{BOUNDARY}"
        request['Authorization'] = @access_token
        if use_cookies
          request['Cookie'] = get_cookies
        end
        response = Net::HTTP.start(uri.host, uri.port,
          use_ssl: true) do |http|
          http.request(request)
        end
      end
      return response
    end

    private

    def refresh_token
      if @expires_at.nil? || @expires_at <= Time.now
        token_info = get_access_token
        @access_token = token_info[:token]
        @expires_at = token_info[:expires_at]
      end
    end

    def get_cookies
      uri = URI("https://#{@app_domain}.tapclicks.com/app/dash/session/login")
      response = Net::HTTP.post_form(uri, email: @email, password: @password)
      return response['set-cookie'].split('; ')[0]
    end

    def get_access_token
      url = "https://api.tapclicks.com/oauth/accesstoken"
      params = {
        client_id: @client_id,
        client_secret: @client_secret,
        grant_type: 'client_credentials'
      }
      uri = URI(url)
      response = Net::HTTP.post_form(uri, params)
      token = JSON.parse(response.body)
      return { token: "Bearer #{token['access_token']}", expires_at: Time.now + token['expires_in'].to_i }
    end

  end
end
