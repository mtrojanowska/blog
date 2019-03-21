require 'rails_helper'


RSpec.describe User, type: :model do
    context 'validation tests' do
      it 'checks username presence' do
        user = User.new(email: 'frog@example.com', password: 'malutka1').save
        expect(user).to eq(false)
      end

      it 'checks username length' do
        user = User.new(username: 'Bo', email: 'bro@gmail.com',  password: 'malutka1').save
        expect(user).to eq(false)
      end

      it 'checks email presence' do
        user = User.new(username: 'Frog', password: 'malutka1').save
        expect(user).to eq(false)
      end


      it 'should save the user' do
        user = User.new(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1').save
        expect(user).to eq(true)
      end
    end
  end
