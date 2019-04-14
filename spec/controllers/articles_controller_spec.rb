# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #index' do
    it 'checks the index functionality' do
      user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
      article2 = Article.create(title: 'Second', content: '22222222222222222222222222222222222222', user_id: user1.id)
      article3 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
      get :index
      expect(assigns(:articles)).to eq([article1, article2, article3])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns requested article to @article' do
      user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
      get :show, params: { id: article1.id }
      expect(assigns(:article)).to eq(article1)
    end

    it 'renders the show template' do
      user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
      get :show, params: { id: article1.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
      session[:user_id] = user1.id
      get :new
      expect(assigns(:article)).to be_a_new(Article)
    end

    it 'renders the new template' do
      user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
      article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
      session[:user_id] = user1.id
      get :new
      expect(response).to render_template :new
    end

    describe 'GET #edit' do
      it 'assigns requested article to @article' do
        user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
        article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
        get :edit, params: { id: article1.id }
        expect(assigns(:article)).to eq(article1)
      end

      it 'renders the edit template' do
        user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
        article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
        session[:user_id] = user1.id
        get :edit, params: { id: article1.id }
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new Article' do
          user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
          session[:user_id] = user1.id
          expect do
            post :create, params: { article: { title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id } }
          end.to change(Article, :count).by(1)
        end
      end

      it 'redirects to the @article' do
        user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
        session[:user_id] = user1.id
        post :create, params: { article: { title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id } }
        expect(response).to redirect_to(Article.last)
      end
    end

    context 'with invalid params' do
      it 'returns a new template' do
        user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
        session[:user_id] = user1.id
        post :create, params: { article: { title: 'First', content: '', user_id: user1.id } }
        expect(response).to render_template :new
      end
    end

    describe 'PUT #update' do
      context 'valid attributes' do
        it 'updates the requested article' do
          user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
          session[:user_id] = user1.id
          article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
          put :update, params: { id: article1.id, article: { title: 'first', content: '11111111111111111111111111111111111111', user_id: user1.id } }
          article1.reload
          expect(article1.title).to redirect_to(article_path(article1))
        end
        it 'redirects to the article' do
          user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
          session[:user_id] = user1.id
          article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
          put :update, params: { id: article1.id, article: { title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id } }
          article1.reload
          expect(response).to redirect_to(article_path(article1))
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested article admin option' do
          user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
          article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)

          user1.toggle!(:admin)
          session[:user_id] = user1.id
          expect do
            delete :destroy, params: { id: article1.id }
          end.to change(Article, :count).by(-1)
        end

        it 'destroys the requested article not admin option' do
          user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
          article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
          session[:user_id] = user1.id
          expect do
            delete :destroy, params: { id: article1.id }
          end.to change(Article, :count).by(-1)
        end

        it 'redirects to the articles list' do
          user1 = User.create(username: 'Frog', email: 'frog@gmail.com', password: 'malutka1')
          article1 = Article.create(title: 'First', content: '11111111111111111111111111111111111111', user_id: user1.id)
          session[:user_id] = user1.id
          delete :destroy, params: { id: article1.id }
          expect(response).to redirect_to(articles_path)
        end
      end
    end
  end
end
