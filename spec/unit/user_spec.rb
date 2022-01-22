require 'user'

describe User do

  describe '.create' do
    it 'adds a new user' do
      user = User.create(email: "test@example.com", password: "password123")
      persisted_data = persisted_data(table: "users", id: user.id)

      expect(user).to be_a User
      expect(user.id).to eq persisted_data['id']
      expect(user.email).to eq "test@example.com"
    end

    it 'hashes the password via BCrypt' do
      expect(BCrypt::Password).to receive(:create).with("password123")
      User.create(email: "test@example.com", password: "password123")
    end
  end

  describe '.find' do
    it 'retrieves the user with the given id' do
      user = User.create(email: "test@example.com", password: "password123")
      retrieved_user = User.find(id: user.id)

      expect(retrieved_user).to be_a User
      expect(retrieved_user.id).to eq user.id
      expect(retrieved_user.email).to eq user.email
    end

    context 'when no id given' do
      it 'returns nil' do
        expect(User.find(id: nil)).to eq nil
      end
    end
  end

  describe '.authenticate' do
    context 'when email and password both correct' do
      it 'returns the user' do
        user = User.create(email: 'test@example.com', password: 'password123')
        authenticated_user = User.authenticate(email: 'test@example.com', password: 'password123')

        expect(authenticated_user).to be_a User
        expect(authenticated_user.id).to eq user.id
        expect(authenticated_user.email).to eq user.email
      end
    end

    context 'when email is incorrect' do
      it 'returns nil' do
        User.create(email: 'test@example.com', password: 'password123')

        expect(User.authenticate(email: 'incorrect@example.com', password: 'password123')).to be_nil
      end
    end

    context 'when password is incorrect' do
      it 'returns nil' do
        User.create(email: 'test@example.com', password: 'password123')

        expect(User.authenticate(email: 'test@example.com', password: 'incorrect password')).to be_nil
      end
    end
  end
end
