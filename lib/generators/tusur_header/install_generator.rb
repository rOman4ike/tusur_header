module TusurHeader
  module Generators
    class InstallGenerator < Rails::Generators::Base

      desc 'Copy TusurHeader default file'
      source_root File.expand_path('../../../../app/views/application', __FILE__)

      def create_partial
        copy_file '_tusur_header.html.erb', 'app/views/application/_tusur_header.html.erb'
      end
    end
  end
end
