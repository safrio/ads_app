module Auth
  module Repositories
    class User
      include Import[db: 'persistance.db']

      def create(name:, email:, password:)
        id = db.execute(%{
          INSERT INTO users(name, email, password) VALUES (?, ?, ?) RETURNING id
        }, name, email, password).first['id']
        find(id: id)
      end

      def find(id:)
        map_raw_result_to_entity(
          db.execute('SELECT * FROM users WHERE id=?', id).first
        )
      end

      def find_by_email(email)
        map_raw_result_to_entity(
          db.execute('SELECT * FROM users WHERE email=?', email).first
        )
      end

      private

      def map_raw_result_to_entity(raw)
        Auth::Entities::User.new(raw)
      end
    end
  end
end
