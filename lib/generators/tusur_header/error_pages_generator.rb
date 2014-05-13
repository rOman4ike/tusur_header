module TusurHeader
  module Generators
    class ErrorPagesGenerator < Rails::Generators::Base

      desc 'Generate 403 404 500 and 502 error pages'
      source_root File.expand_path("../templates", __FILE__)

      def copy_error_pages
        copy_file "403.html", "public/403.html"
        copy_file "404.html", "public/404.html"
        copy_file "500.html", "public/500.html"
        copy_file "502.html", "public/502.html"
      end

    end
  end
end
