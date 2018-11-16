
require 'rails_helper'

RSpec.describe UsersController, type: :controller do 
  describe "POST #create" do 
    context "with valid params" do 
      it "logs in the user after sign up" do 
        post :create, params: { users: {username: 'kat', password: 'password'} }
        user = User.find_by(username: 'kat')
        expect(session[:session_token]).to eq(user.session_token)
      end
      
      it "redirects the user to their showpage" do 
        post :create, params: { users: {username: 'kat', password: 'password'} }
        user = User.find_by(username: 'kat')
        expect(response).to redirect_to user_url(user)
      end 
    end
    
    context "with invalid params" do 
      it "renders errors" do 
        post :create, params: { users: {username: 'kat', password: 'pass'} }
        expect(response).to redirect_to new_user_url
        expect(flash[:errors]).to be_present
      end
    end
  end
  
  describe "PATCH #update" do
    context "with valid parameters" do 
      it "updates the user's username" do 
        user1 = User.create(username: 'kat', password: 'password')
        patch :update, params: {id: user1.id, users: {username: 'koolkat', password: 'password'} }
        user = User.find_by(id: user1.id)
        expect(user.username).to eq('koolkat')
        expect(response).to redirect_to(user_url(user))
      end 
      
      it "updates the user's password" do 
        user1 = User.create(username: 'kat', password: 'password')
        patch :update, params: {id: user1.id, users: {username: 'kat', password: 'password1'} }
        user = User.find_by(id: user1.id)
        expect(user.is_password?('password1')).to be(true) 
        expect(response).to redirect_to(user_url(user))
      end
    end 
  
    context "with invalid parameters" do 
      it "does not update the user's username" do 
        user1 = User.create(username: 'kat', password: 'password')
        user2 = User.create(username: 'Christina', password: 'password')
        patch :update, params: {id: user1.id, users: {username: 'Christina', password: 'password'} }
        user = User.find_by(id: user1.id)
        expect(user.username).to eq('kat')
        expect(response).to redirect_to(user_url(user))
      end 
      it "does not update the user's password"
    end 
  
  end 
    
  describe "GET #show" do
    it "shows the user's page" do
      user = User.create(username: 'Christina', password: 'password')
      get :show, params: {id: user.id}
      expect(response).to render_template(:show)
    end
  end

  describe "GET #index" do 
    it "shows all the users" do 
      user1 = User.create(username: 'Christina', password: 'password')
      user1 = User.create(username: 'kat', password: 'password')
      get :index 
      expect(response).to render_template(:index)
    end 
  end 

end