module TapclicksApi
  class Service

    BOUNDARY = "TapClicksPROOMXNTDSZXIDECPOTOKOUVUOWSIUYFCIZSAZMQNGDGPVOIHPDIGOIIN"

    def initialize(options={})
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @access_token = get_access_token
    end

    def request(method, url, params={}, headers={})
      headers.merge!( { Authorization: "Bearer #{@access_token}" } ) if !@access_token.nil?
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
        response = Net::HTTP.start(uri.host, uri.port,
          use_ssl: true) do |http|
          http.request(request)
        end
      end
      return response
    end

    private

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
      return "Bearer #{token['access_token']}"
    end

  end
end
