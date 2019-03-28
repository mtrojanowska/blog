require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:article_categories) }
  it { should have_many(:categories).through(:article_categories) }


  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(3) }
  it { should validate_length_of(:title).is_at_most(25) }

  it { should validate_presence_of(:content) }
  it { should validate_length_of(:content).is_at_least(25) }


  it { should validate_presence_of(:user_id) }
end
