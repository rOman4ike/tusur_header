module UserMenu
  class UserLinks
    include Rails.application.routes.url_helpers

    class Link < Struct.new(:title, :url, :options, :separator)
      include ActionView::Helpers

      def to_s
        link_to title, url, options
      end

      def separator?
        !!separator
      end
    end


    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def links
      return [] unless user

      links_data.map { |e| Link.new e[:title], e[:url], e[:options], e[:separator] }
    end

    delegate :uid, :teacher?, :student?, :to => :user

    def app_name
      user.app_name
    end

    def system_infos
      RedisUserConnector.get(user.id).select{|k,_| k =~ %r((?<!#{app_name})_info)}
    end

    def links_data
      @links_hash ||= begin
                        array = []

                        system_infos.each do |system, info|
                          info_hash = JSON.parse(info)
                          next if info_hash['permissions'].empty?

                          title = I18n.t("remote_system.#{system.split('_').first}")
                          url = info_hash['url']

                          array << {:title => title, :url => url}
                        end

                        array << { :separator => true }

                        array << { :title => 'Редактировать профиль', :url => 'http://profile.openteam.ru/users/edit' }
                        array << { :title => 'Выход', :url => '#log_out', :options => { :method => :delete } }

                        array
                      end
    end
  end

  def menu_links
    UserLinks.new(self).links
  end
end
