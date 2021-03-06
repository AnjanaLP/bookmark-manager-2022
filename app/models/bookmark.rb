require_relative 'database_connection'
require_relative 'comment'
require_relative 'tag'
require_relative 'bookmark_tag'
require 'uri'

class Bookmark
  VALID_URL_REGEX = /\A#{URI::regexp}\z/

  def self.all
   result = DatabaseConnection.query( "SELECT * FROM bookmarks" )
   result.map do |bookmark|
     Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
   end
 end

  def self.create(title:, url:)
   return false unless valid?(url)
   result = DatabaseConnection.query("INSERT INTO bookmarks (title, url) VALUES($1, $2) RETURNING id, title, url;", [title, url])
   Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id:, comment_class: Comment, bookmark_tag_class: BookmarkTag)
    comment_class.delete(bookmark_id: id)
    bookmark_tag_class.delete(bookmark_id: id)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = $1;", [id])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = $1;", [id])
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.update(id:, title:, url:)
    result = DatabaseConnection.query(
      "UPDATE bookmarks SET title = $1, url = $2 WHERE id = $3 RETURNING id, title, url;" , [title, url, id]
    )
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.where(tag_id:)
    result = DatabaseConnection.query(
      "SELECT id, title, url FROM bookmarks_tags INNER JOIN bookmarks ON bookmarks.id = bookmarks_tags.bookmark_id WHERE bookmarks_tags.tag_id = $1;",
      [tag_id]
    )
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end

  def tags(tag_class = Tag)
    tag_class.where(bookmark_id: id)
  end

  private

  def self.valid?(url)
    url =~ VALID_URL_REGEX
  end
end
