require './app/models/database_connection'

task :setup_test_database do
  DatabaseConnection.setup('bookmark_manager_test')
  DatabaseConnection.query("TRUNCATE TABLE bookmarks, comments, tags, bookmarks_tags, users;")
end

task :setup do
  p "Setting up test and development databases..."

  ['bookmark_manager', 'bookmark_manager_test'].each do |database|
    DatabaseConnection.setup
    DatabaseConnection.query("CREATE DATABASE #{ database };")
    DatabaseConnection.setup(database)
    DatabaseConnection.query("CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60));")
    DatabaseConnection.query("ALTER TABLE bookmarks ADD COLUMN title VARCHAR(60);")
    DatabaseConnection.query("CREATE TABLE comments(id SERIAL PRIMARY KEY, text VARCHAR(240), bookmark_id INTEGER REFERENCES bookmarks (id));")
    DatabaseConnection.query("CREATE TABLE tags(id SERIAL PRIMARY KEY, content VARCHAR(60));")
    DatabaseConnection.query("CREATE TABLE bookmarks_tags(tag_id INTEGER REFERENCES tags (id), bookmark_id INTEGER REFERENCES bookmarks (id));")
    DatabaseConnection.query("CREATE TABLE users (id SERIAL PRIMARY KEY, email VARCHAR(60), password VARCHAR(140));")
  end
end
