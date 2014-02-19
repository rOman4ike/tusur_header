module TusurHeader
  class Engine < ::Rails::Engine
    def self.sites
      @sites ||= YAML.load_file(File.expand_path('../../../config/sites.yml', __FILE__))
    end
  end
end

