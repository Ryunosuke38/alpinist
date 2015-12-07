module Main
  class Application < Rodakase::Application
    route "users" do |r|
      r.on "new" do
        r.is to: "main.views.users.new"
      end

      r.on ":id" do |user_id|
        r.on "edit" do
          r.is to: "main.views.users.edit", call_with: [id: user_id]
        end

        r.post do
          r.resolve "main.operations.update_user" do |update_user|
            update_user.(r[:user]).match do |m|
              m.success do
                r.redirect "/users"
              end

              m.failure do |errors|
                r.resolve "main.views.users.edit" do |view|
                  view.(user: r[:user], errors: errors)
                end
              end
            end
          end
        end
      end

      r.post do
        r.resolve "main.operations.create_user" do |create_user|
          create_user.(r[:user]).match do |m|
            m.success do
              r.redirect "/users"
            end

            m.failure do |errors|
              r.resolve "main.views.users.new" do |view|
                view.(user: r[:user], errors: errors)
              end
            end
          end
        end
      end

      r.is to: "main.views.users.index"
    end
  end
end
