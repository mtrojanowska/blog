require 'rails_helper'

RSpec.describe Article, type: :model do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:article_categories) }
  it { is_expected.to have_many(:categories).through(:article_categories) }


  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_least(3) }
  it { is_expected.to validate_length_of(:title).is_at_most(25) }

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_least(25) }


  it { is_expected.to validate_presence_of(:user_id) }
end
