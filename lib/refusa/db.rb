
Jdbc::SQLite3.load_driver

# ActiveRecord::Base.establish_connection(
  # :adapter => "jdbc",
  # :driver => "org.sqlite.JDBC",
  # :url => "jdbc:sqlite:/db/refusa.sqlite",
  # :connection_alive_sql => "SELECT COUNT(*) from test_table"
# )

def db
  @db ||= build_db
end 

def build_db
  db = Sequel.connect('jdbc:sqlite:db.sqlite3')

  unless db.table_exists?(:items)
    db.create_table :items do
      column :name, :text
      column :price, :float
    end
  end
  db
end