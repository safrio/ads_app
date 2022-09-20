Container.register_provider(:db) do |container|
  prepare do
    use :settings

    require 'sqlite3'

    db = SQLite3::Database.open (target[:settings].db_name)
    # db = SQLite3::Database.open 'ads.db'
    db.results_as_hash = true

    # db = ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'dbfile.sqlite3')

    register('persistance.db', db)
  end

  start do
    # -------- Terrible code, don't do it in production. Use regular migration flow ---------

    container['persistance.db'].execute(
      %{
        CREATE TABLE IF NOT EXISTS ads(
          id         INTEGER PRIMARY KEY,
          user_id    INTEGER,

          title       VARCHAR(255),
          description TEXT,
          city        VARCHAR(255),
          lat         FLOAT,
          lon         FLOAT
        )
      }
    )

    # container['persistance.db'].execute(
    #   %{
    #     CREATE TABLE IF NOT EXISTS orders(
    #       id         INTEGER PRIMARY KEY,
    #       account_id INT,
    #       status     TEXT DEFAULT 'open',

    #       FOREIGN KEY(account_id) REFERENCES accounts(id)
    #     )
    #   }
    # )

    container['persistance.db'].execute(
      %{
        CREATE TABLE IF NOT EXISTS users(
          id              INTEGER PRIMARY KEY,

          name            VARCHAR(255),
          email           VARCHAR(255),
          password VARCHAR(255)
        )
      }
    )

    container['persistance.db'].execute(
      %{
         CREATE UNIQUE INDEX IF NOT EXISTS unique_users_email ON users (email)
      }
    )

    container['persistance.db'].execute(
      %{
        CREATE TABLE IF NOT EXISTS user_sessions(
          id              INTEGER PRIMARY KEY,

          uuid VARCHAR(255),
          user_id INT,

          FOREIGN KEY(user_id) REFERENCES users(id)
        )
      }
    )

    # ---------------------------------------------------------------------------------------
  end

  stop do
    container['persistance.db'].close
  end
end
