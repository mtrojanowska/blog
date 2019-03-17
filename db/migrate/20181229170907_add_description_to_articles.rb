# frozen_string_literal: true

class AddDescriptionToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :description, :string
  end
end
