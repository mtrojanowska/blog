require 'rails_helper'

RSpec.describe User, type: :model do
    context 'relation test' do
      it { is_expected.to have_many(:articles) }
          # user = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
          # article1 = Article.create(title: "Title", content: "Some contentafhkjdjkhjhljhlkhkjlhkjhlhfkhfa", user_id: user.id)
          # article2 = Article.create(title: "Title1", content: "Some contejfahljhfdhfajdhfljdshflkjhdsflajh", user_id: user.id)
          # expect(user.articles).to eq([article1, article2])
    end

     context 'validation tests' do
      it 'checks username presence' do
        user = User.new(username: 'Frog', password: 'malutka1', email: 'frog@example.com')
        username_validation = user.valid?
        expect(username_validation).to be true
      end

      it 'checks username absence' do
        user = User.new(username: '')
        username_validation = user.valid?
        expect(username_validation).to be false
      end

      it 'checks if the username is too short' do
        user = User.new(username: 'Bo')
        username_validation = user.valid?
        expect(user.errors[:username]).to eq(["is too short (minimum is 3 characters)"])
      end

      it 'checks email absence' do
        user = User.new(email: '')
        username_validation = user.valid?
        expect(user.errors[:email].first).to eq("can't be blank")
      end

      it "passes when email is invalid" do
        user = User.new(email: 'joh@doe')
        username_validation = user.valid?
        expect(user.errors[:email].last).to eq('is invalid')
      end

      it "checks the password presence" do
        user = User.new(username: 'Frog', password: 'malutka1', email: 'frog@example.com')
        user_validation_result = user.valid?
        expect(user_validation_result).to eq(true)
      end

      it "checks the password absence" do
        user = User.new(username: 'Frog', email: 'frog@gmail.com')
        user.save
        expect(user.persisted?).to eq(false)
        # user_validation_result = user.valid?
        # expect(user_validation_result).to eq(false)
        # expect { user.save }.not_to change(User, :count)
      end

     it "checks the password digest" do
       user = User.create(username: 'Frog', password: 'malutka1', email: 'frog@example.com')
       expect(user.password_digest).not_to eq(nil)
    end


      it 'checks uniqueness' do
        user1 = User.create(username: 'Frog', password: 'malutka1', email: 'frog@example.com')
        user2 = User.create(username: 'frog', password: 'malutka1', email: 'grog@example.com')
        expect(user2.errors[:username].first).to eq("has already been taken")
        # expect(user2.persisted?).to eq(false)
      end


      it 'should create a valid user' do
        user = User.new(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
        expect { user.save }.to change(User, :count)
      end

  end
end
