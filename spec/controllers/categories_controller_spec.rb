# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    it 'checks the index functionality' do
      category1 = Category.create(name: 'Alektorofobia')
      category2 = Category.create(name: 'Trypofobia')
      category3 = Category.create(name: 'Ataksofobia')
      get :index
      expect(assigns(:categories)).to eq([category1, category2, category3])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end
end
