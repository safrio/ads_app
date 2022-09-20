module Auth
  module Repositories
    class UserSession
      include Import[db: 'persistance.db']

      def create(user_id:)
        session = map_raw_session_to_entity(user_id: user_id, uuid: '')
        id = db.execute(%{
          INSERT INTO user_sessions(uuid, user_id) VALUES (?, ?) RETURNING id
        }, session.uuid, session.user_id).first['id']
        find(id: id)
      end

      def find(id:)
        map_raw_session_to_entity(
          db.execute('SELECT * FROM user_sessions WHERE id=?', id).first
        )
      end

      def find_by_uuid(uuid)
        map_raw_session_to_entity(
          db.execute('SELECT * FROM user_sessions WHERE uuid=?', uuid).first
        )
      end

      private

      def map_raw_session_to_entity(raw)
        Auth::Entities::UserSession.new(raw)
      end
    end
  end
end
