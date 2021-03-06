require "slim"
require "rodakase/view"

require "api/container"
require "api/page"

module Api
  Container.register "api.page", Page.new(Container.config)

  class View < Rodakase::View::Layout
    setting :root, Container.root.join("web/templates")
    setting :scope, Container["api.page"]
    setting :engine, :slim
    setting :name, "application"

    def locals(options)
      # Temporary workaround for a rodakase bug, which fails to render if this hash is empty
      {foo: "bar"}
    end

    # Example of alternative layouts
    # class Admin < View
    #   setting :name, "admin"
    # end
  end
end
