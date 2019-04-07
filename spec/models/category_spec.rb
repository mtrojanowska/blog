require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'relation test' do
    it { is_expected.to have_many(:article_categories) }
    it { is_expected.to have_many(:articles).through(:article_categories) }
  end

  context 'validation'do
    it 'checks presence of the category name' do
      category = Category.new(name: "Kanibalism")
      name_validation = category.valid?
      expect(name_validation).to be true
    end

    it 'checks username absence' do
      category = Category.new(name: '')
      name_validation = category.valid?
      expect(name_validation).to be false
    end
  end

  it 'checks uniqueness' do
    user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
    user1.toggle!(:admin)
    category1 = Category.create(name: "Kanibalism")
    category2 = Category.create(name: "Kanibalism")
    expect(category2.persisted?).to eq(false)
  end
end
