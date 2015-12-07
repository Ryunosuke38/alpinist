module Persistence
  module Relations
    class Users < ROM::Relation[:sql]
      dataset :users
      register_as :users

      def by_id(id)
        where(id: id)
      end
    end
  end
end
