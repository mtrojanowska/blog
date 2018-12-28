class Article < ApplicationRecord
  validates :title, presence: true, length:{minimum: 3, maximum: 25}
  validates :content, presence: true, length:{minimum: 25, maximum: 25}
end
