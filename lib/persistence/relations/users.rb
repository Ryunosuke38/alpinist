module Persistence
  module Relations
    class Users < ROM::Relation[:sql]
      dataset :users
      register_as :users

      use :pagination
      per_page 40

      def by_id(id)
        where(id: id)
      end
    end
  end
end
