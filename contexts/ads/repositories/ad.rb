module Ads
  module Repositories
    class Ad
      include Import[db: 'persistance.db']

      def create(title:, description:, city:)
        # binding.irb
        id = db.execute(%{
          INSERT INTO ads(title, description, city, lat, lon, user_id) VALUES (?, ?, ?, ?, ?, ?) RETURNING id
        }, title, description, city, 1, 2, 1).first['id']
        find(id: id)
      end

      def find(id:)
        map_raw_result_to_entity(
          db.execute("SELECT * FROM ads WHERE id=?", id).first
        )
      end

      def all_order_desc
        db.execute("SELECT * FROM ads ORDER BY id DESC")
      end

      private

      def map_raw_result_to_entity(raw)
        Ads::Entities::Ad.new(raw)
      end
    end
  end
end
