#Intercept file writes, determine if it is local or remote, save the file, return to the application.
require 'uri'
require 'net/http'
require 'pathname'

module GoodData::Bricks

  class FsMiddleware < GoodData::Bricks::Middleware

    def call(params)
      path = params[:BRICK_FILE_PATH]
      project_id = params[:GDC_PROJECT_ID]
      username = params[:GDC_USERNAME]
      password = params[:GDC_PASSWORD]
      env = ENV['runtime_env']

      def write(result)
        uri = URI.parse("https://#{server_name}/project-uploads/#{project_id}/")
        file = Pathname.new(path).basename.to_s
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Put.new("#{uri.request_uri}/#{file}")
        request.basic_auth username, password
        request.body_stream = File.open(file)
        request["Content-Type"] = "multipart/form-data"
        request.add_field('Content-Length', File.size(file))
        response = http.request(request)
      end

      returning(@app.call(params)) do |result|
        write(result) unless env = 'local'
      end
    end

  end
end