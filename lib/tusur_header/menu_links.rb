module TusurHeader
  class Link
    include ActionView::Helpers

    attr_accessor :title, :url, :options

    def initialize(title, url, options, separator)
      @title, @url, @options, @separator = title, url, options, separator
    end

    def to_s
      (separator? ? separator : link) rescue ''
    end

    def link
      content_tag :li, link_to(title, url, options).html_safe
    end

    def separator?
      !!@separator
    end

    def separator
      content_tag :li, nil, class: 'divider'
    end
  end

  class Links
    include ActionView::Helpers

    attr_accessor :user
    delegate :uid, :teacher?, :student?, :app_name, to: :user

    def initialize(user)
      @user = user
    end

    def links
      return [] unless user

      links_data.map { |e| Link.new e[:title], e[:url], e[:options], e[:separator] }
    end

    def list
      content_tag :ul, links.join.html_safe, class: 'dropdown-menu'
    end

    def system_infos
      RedisUserConnector.get(user.id).select { |k,_| k =~ /_info/ }
    end

    def profile_url
      'https://profile.tusur.ru'
    end

    def edit_user_link
      Settings['profile.url'] || profile_url
    end

    def edit_user_url
      %(#{edit_user_link}/#{I18n.locale}/users/edit)
    end

    def sign_out_link
      Settings['profile.url'] || profile_url
    end

    def sign_out_url
      "#{sign_out_link}/#{I18n.locale}/users/sign_out?redirect_url=#{Settings['app.url']}"
    end

    def links_from_system_infos(key)
      system_infos.inject([]) do |array, data|
        array += JSON.parse(data.last).select { |k, _| k.to_s == key }.values
      end
    end

    def links_data
      @links_hash ||= begin

                        my_urls = []
                        if links_from_system_infos('my_url').any?
                          links_from_system_infos('my_url').reject{ |elem| elem['link'].blank? }.each do |elem|
                            my_urls << { title: elem['title'], url: elem['link'] }
                          end

                          my_urls = my_urls.sort{ |a, b| a[:title] <=> b[:title] }
                          my_urls << { separator: true }
                        end

                        urls = []
                        urls << { title: I18n.t('menu_links.profile'), url: "#{profile_url}/#{I18n.locale}/dashboard" }
                        if links_from_system_infos('url').any?
                          links_from_system_infos('url').reject{ |elem| elem['link'].blank? }.each do |elem|
                            urls << { title: elem['title'], url: elem['link'] }
                          end
                        end

                        urls = urls.sort{ |a, b| a[:title] <=> b[:title] }
                        urls << { separator: true }

                        array = my_urls + urls
                        array << { title: I18n.t('menu_links.edit_profile'), url: edit_user_url }
                        array << { title: I18n.t('menu_links.sign_out'), url: sign_out_url, options: { method: :delete } }

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
