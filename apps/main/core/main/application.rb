require "rodakase/application"
require "either_result_matcher/either_extensions"
require_relative "container"

module Main
  class Application < Rodakase::Application
    configure do |config|
      config.routes = "web/routes".freeze
      config.container = Container
    end

    opts[:root] = Pathname(__FILE__).join("../..").realpath.dirname

    use Rack::Session::Cookie, key: "alpinist.session", secret: Alpinist::Container.config.app.session_secret

    plugin :indifferent_params
    plugin :flash

    route do |r|
      self.class.config.container["main.page"].flash_messages = flash

      r.root do
        r.resolve "main.views.home" do |home|
          home.()
        end
      end

      r.on "sign_in" do
        r.is to: "main.views.sign_in"
      end

      r.on "sessions" do
        r.post do
          r.resolve "main.sessions.sign_in" do |sign_in|
            if sign_in.(r[:user], session)
              r.redirect "/users"
            else
              r.redirect "/sign_in"
            end
          end
        end
      end

      r.multi_route
    end

    load_routes!

    def current_user
      env["alpinist.current_user"]
    end

    def set_current_user!(user)
      env["alpinist.current_user"] = user
    end
  end
end
