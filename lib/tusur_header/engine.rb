require 'compass-rails'
require 'bootstrap-sass'
require 'jquery-rails'

module TusurHeader
  class Engine < ::Rails::Engine
    def self.sites
      @sites ||= YAML.load_file(File.expand_path('../../../config/sites.yml', __FILE__))
    end

    config.after_initialize do
      begin
        Settings.define 'profile.url', :require => true

        Settings.resolve!
      rescue => e
        puts "WARNING! #{e.message}"
      end
    end

    config.to_prepare do
      ActiveRecord::Base.class_eval do
        def self.has_remote_notifications
          define_method :get_notification_count do
            response = RestClient.get("#{Settings['profile.url']}/api/notifications", :params => { :uid => self.uid }, :content_type => :json, :accept => :json)
            response.body['notifications']
          end
        end
      end
    end
  end
end

