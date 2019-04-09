require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:page1) { create :page }
  let(:page) { create :page, parent: page1 }

  describe 'GET#index' do
    let(:pages) { create_list(:page, 3) }
    before { get :index }

    it 'populates an array of all pages' do
      expect(assigns(:pages)).to match_array(pages)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET#show' do
    before { get :show, params: { id: page} }

    it 'assigns the requested page to @page' do
      expect(assigns(:page)).to eq page
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET#add' do
    before { get :new }

    it 'assigns a new page to @page' do
      expect(assigns(:page)).to be_a_new(Page)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET#edit' do
    before { get :edit, params: { id: page} }

    it 'assigns the requested page to @page' do
      expect(assigns(:page)).to eq page
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST#create' do
    context 'with valid attributes' do
      it 'save a new page in the database' do
        count = Page.count

        expect{ post :create, params: { page: attributes_for(:page)} }.to change(Page, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { page: attributes_for(:page)}
        expect(response).to redirect_to assigns(:page)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the page' do
        expect{ post :create, params: { page: attributes_for(:page, :invalid)} }.to_not change(Page, :count)
      end

      it 're-renders new view' do
        post :create, params: { page: attributes_for(:page, :invalid)}
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH#update' do
    context 'with valid attributes' do
      it 'assigns the requested page to @page' do
        patch :update, params: { id: page, page: attributes_for(:page) }
        expect(assigns(:page)).to eq page
      end

      it 'changes page attributes' do
        patch :update, params: { id: page, page: { title: 'new title', body: 'new body'} }
        page.reload

        expect(page.title).to eq 'new title'
        expect(page.body).to eq 'new body'
      end

      it 'redirects to updated page' do
        patch :update, params: { id: page, page: attributes_for(:page) }
        expect(response).to redirect_to page
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: page, page: attributes_for(:page, :invalid) } }

      it 'does not change page' do
        page.reload

        expect(page.title).to eq 'MyString'
        expect(page.body).to eq 'MyText'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE#destroy' do
    let!(:page) { create :page }

    it 'deletes the page' do
       expect{ delete :destroy, params: { id: page } }.to change(Page, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: page }
      expect(response).to redirect_to pages_path
    end
  end
end
