module Main
  class Application < Rodakase::Application
    route "users" do |r|
      r.is to: "main.views.users.index"
    end
  end
end
