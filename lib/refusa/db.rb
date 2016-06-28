
Jdbc::SQLite3.load_driver

# ActiveRecord::Base.establish_connection(
  # :adapter => "jdbc",
  # :driver => "org.sqlite.JDBC",
  # :url => "jdbc:sqlite:/db/refusa.sqlite",
  # :connection_alive_sql => "SELECT COUNT(*) from test_table"
# )

::LOGIN_PROTOCOLS = [
    {:name => 'Pasadena', 
    :url => 'http://ezproxy.pasadenapubliclibrary.net/login?url=http://www.referenceusa.com/login',
    :user_id => '29009016461368',
    :user_id_selector => 'user',
    :submit_text => 'Login'
    },
    {:name => 'SF', 
    :url => 'http://ezproxy.sfpl.org/login?url=http://www.referenceusa.com/login',
    :user_id => '21223202546787',
    :user_id_selector => 'barcode',
    :pin => '1216',
    :pin_selector => 'pin', 
    :submit_text => 'Submit'
   }
]

def db
  @db ||= build_db
end 

def build_db
  db = Sequel.connect('jdbc:sqlite:db.sqlite3')

  unless db.table_exists?(:logins)
    db.create_table :logins do
      column :name, :string
      column :url, :string
      column :user_id, :string
    end
  end
  db
end