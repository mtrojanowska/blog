# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories

  validates :title, presence: true, length: { minimum: 3, maximum: 25 }
  validates :content, presence: true, length: { minimum: 25 }
  validates :user_id, presence: true
end
