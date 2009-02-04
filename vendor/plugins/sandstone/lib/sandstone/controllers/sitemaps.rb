module Sandstone
  module Controllers
    module Sitemaps
      def show
        @pages = Page.find_roots(current_subsite, true)
      end
    end
  end
end
