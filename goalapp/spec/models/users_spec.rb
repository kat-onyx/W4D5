require 'rails_helper'

RSpec.describe User, type: :model do 
  subject(:user) { User.create(username: 'kat', password: '123456') }
  
  describe "user validates" do 
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_length_of(:password).is_at_least(6)}
    
    it "should validate presence of session token" do   
      expect(user.session_token).not_to be_nil
    end 
  end 
  
  describe "class methods" do 
    it "finds users by credentials" do 
      user = User.create(username: 'kat', password: '123456')
      expect(User.find_by_credentials('kat', '123456')).to eq(user)
    end
  end
  
  describe "#password_digest" do 
    it "evaluates password_digest to submitted password" do 
      user = User.create(username: 'christina', password: 'password')
      expect(user.password_digest.length).to be > (user.password.length)
    end 
  end 
  
  describe "#is_password?" do 
    it "returns true if the given password is the user's password" do 
      user = User.create(username: 'christina', password: 'password')
      expect(user.is_password?('password')).to be(true)
    end
    it "returns false if the give password is not the user's password" do 
      user = User.create(username: 'christina', password: 'password')
      expect(user.is_password?('hello')).to be(false)
    end
  end
  
end 