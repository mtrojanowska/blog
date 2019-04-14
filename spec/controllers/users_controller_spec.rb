# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'checks the index functionality' do
      user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      user2 = User.create(username: 'Grog', email: 'grog@gmail.com', password: 'malutka1')
      user3 = User.create(username: 'Smog', email: 'smog@gmail.com', password: 'malutka1')
      get :index

      expect(assigns(:users)).to eq([user1, user2, user3, user4])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns requested user to @user' do
      user = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      session[:user_id] = user.id
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the show template' do
      user = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      get :show, params: { id: user.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'assigns requested user to @user' do
      user = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      session[:user_id] = user.id
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the edit template' do
      user = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      session[:user_id] = user.id
      get :edit, params: { id: user.id }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect do
          post :create, params: { user: { username: 'Frog', email: 'frog@gmail.com', password: 'malutka1' } }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the @user' do
        post :create, params: { user: { username: 'Frog', email: 'frog@gmail.com', password: 'malutka1' } }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid params' do
      it 'returns a new template' do
        post :create, params: { user: { username: '', email: 'frog@gmail.com', password: 'malutka1' } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    context 'valid attributes' do
      it 'updates the requested user' do
        user = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
        session[:user_id] = user.id
        put :update, params: { id: user.id, user: { username: 'Sloggy', email: 'frog@gmail.com', password: 'malutka1' } }
        user.reload
        expect(user.username).to eq('Sloggy')
      end

      it 'redirects to the user' do
        user = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
        session[:user_id] = user.id
        put :update, params: { id: user.id, user: { username: 'Sloggy', email: 'frog@gmail.com', password: 'malutka1' } }
        user.reload
        expect(response).to redirect_to(articles_path)
      end
    end

    context 'invalid attributes' do
      it 'updates the requested user' do
        user = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
        session[:user_id] = user.id
        put :update, params: { id: user.id, user: { username: '', email: '', password: '' } }
        user.reload
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      user3 = User.create(username: 'Smog', email: 'smog@gmail.com', password: 'malutka1')
      user3.toggle!(:admin)
      session[:user_id] = user3.id
      expect do
        delete :destroy, params: { id: user1.id }
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      user3 = User.create(username: 'Smog', email: 'smog@gmail.com', password: 'malutka1')
      user3.toggle!(:admin)
      session[:user_id] = user3.id
      delete :destroy, params: { id: user1.id }
      expect(response).to redirect_to(users_path)
    end
  end
end
