module TusurHeader
  class Link
    include ActionView::Helpers

    attr_accessor :title, :url, :options

    def initialize(title, url, options, separator)
      @title, @url, @options, @separator = title, url, options, separator
    end

    def to_s
      separator? ? separator : link
    end

    def link
      content_tag :li, link_to(title, url, options).html_safe
    end

    def separator?
      !!@separator
    end

    def separator
      content_tag :li, nil, :class => 'divider'
    end
  end

  class Links
    include ActionView::Helpers

    attr_accessor :user
    delegate :uid, :teacher?, :student?, :app_name, :to => :user

    def initialize(user)
      @user = user
    end

    def links
      return [] unless user

      links_data.map { |e| Link.new e[:title], e[:url], e[:options], e[:separator] }
    end

    def list
      content_tag :ul, links.join.html_safe, :class => 'dropdown-menu'
    end

    def system_infos
      RedisUserConnector.get(user.id).select{|k,_| k =~ %r((?<!#{app_name})_info)}
    end

    def profile_url
      'http://profile.tusur.ru'
    end

    def edit_user_link
      Settings['profile.url'] || profile_url
    end

    def edit_user_url
      edit_user_link + '/users/edit'
    end

    def sign_out_link
      Settings['profile.url'] || profile_url
    end

    def sign_out_url
      path = "/users/sign_out?redirect_url=#{Settings['app.url']}"

      sign_out_link + path
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

                        array << { :title => 'Редактировать профиль', :url => edit_user_url }
                        array << { :title => 'Выход', :url => sign_out_url, :options => { :method => :delete } }

                        array
                      end
    end
  end

  module MenuLinks
    def menu_links
      Links.new(self).links
    end

    def menu_list
      Links.new(self).list
    end
  end
end
