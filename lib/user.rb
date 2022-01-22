require 'bcrypt'

class User

  def self.create(email:, password:)
    hashed_password = hashed_password(password)
    result = DatabaseConnection.query("INSERT INTO users (email, password) VALUES($1, $2) RETURNING id, email;", [email, hashed_password])
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.find(id:)
    return unless id
    result = DatabaseConnection.query("SELECT * FROM users WHERE id = $1;", [id])
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.authenticate(email:, password:)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = $1", [email]).first
    return unless result && correct_password?(result['password'], password)
    User.new(id: result['id'], email: result['email'])
  end

  attr_reader :id, :email

  def initialize(id:, email:)
    @id = id
    @email = email
  end

  private

  def self.hashed_password(password)
    BCrypt::Password.create(password)
  end

  def self.correct_password?(hashed_password, submitted_password)
    BCrypt::Password.new(hashed_password) == submitted_password
  end
end
