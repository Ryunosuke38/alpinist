require "main/entities/user"

module Main
  module Persistence
    module Repositories
      class Users < ROM::Repository
        relations :users

        def [](id)
          users.where(id: id).as(Entities::User).one
        end

        def by_email(email)
          users.where(email: email).as(Entities::User).first
        end

        def index(page: 1, per_page: 40)
          users.per_page(per_page).page(page).as(Entities::User)
        end
      end
    end
  end
end
