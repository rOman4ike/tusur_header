require 'rest_client'
require 'tusur_cdn'

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
        def self.has_remote_profile
          define_method :remote_profile do |kind|
            response = RestClient.get("#{Settings['profile.url']}/api/#{kind}", :params => { :uid => self.uid }, :content_type => :json, :accept => :json)
            JSON.parse(response)[kind]
          end

          define_method :get_notifications do
            @get_notification_count ||= remote_profile('notifications').to_i
          end

          define_method :get_menu do
            @get_menu ||= (remote_profile('menu') || [])
          end
        end
      end
    end

  end
end
