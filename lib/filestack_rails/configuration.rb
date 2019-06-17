module FilestackRails
  class Configuration
    attr_accessor :api_key, :client_name, :secret_key, :expiry, :app_secret, :cname, :version

    def api_key
      @api_key or raise "Set config.filestack_rails.api_key"
    end

    def client_name
      @client_name or 'filestack_client'
    end

    def version
      @version or 'v3'
    end

    def expiry
      @expiry or ( Time.zone.now.to_i + 600 )
    end

    def security=(security_options = {})
      raise 'You must have secret key to use security' if @app_secret.nil?

      @security_options = security_options
      FilestackSecurity.new(@app_secret, options: security_options)
    end

    def security
      raise 'You must have secret key to use security' if @app_secret.nil?
      FilestackSecurity.new(@app_secret, options: @security_options || {})
    end
  end
end
