require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'allows a signup if passwords match' do
      @user = User.new(first_name: "Archie", last_name: "Cohen", email: "archiecohen@archiecohen.com", password: "abc123", password_confirmation: "abc123")

      expect(@user.valid?).to be true

    end

    it "doesn't allow a signup if passwords don't match" do

      @user = User.new(first_name: "Archie", last_name: "Cohen", email: "archiecohen@archiecohen.com", password: "abc123", password_confirmation: "abc124")

      expect(@user.valid?).to be false

    end

    it "must have a unique email" do
      @user = User.create(first_name: "Archie", last_name: "Cohen", email: "archiecohen@archiecohen.com", password: "abc123", password_confirmation: "abc123")
      @user1 = User.new(first_name: "Archer", last_name: "Cohen", email: "archiecohen@archiecohen.com", password: "abc123", password_confirmation: "abc123")
      
      expect(@user1.valid?).to be false

    end

    it "must require a first name" do
      @user = User.new(first_name: nil, last_name: "Cohen", email: "archiecohen@archiecohen.com", password: "abc123", password_confirmation: "abc123")
      
      expect(@user.valid?).to be false
    end

    it "must require a last name" do
      @user = User.new(first_name: "Archie", last_name: nil, email: "archiecohen@archiecohen.com", password: "abc123", password_confirmation: "abc123")
      
      expect(@user.valid?).to be false
    end

    it "must have a minimum length when account is created" do
      @user = User.new(first_name: "Archie", last_name: "Cohen", email: "archiecohen@archiecohen.com", password: "abc", password_confirmation: "abc")
      
      expect(@user.valid?).to be false
    end

  end

  describe '.authenticate_with_credentials' do
    
    it "should allow users to log in with spaces before and/or after the email" do
      user = User.create(first_name: "Archie", last_name: "Cohen", email: "archiecohen@archiecohen.com", password: "abc123", password_confirmation: "abc123")
      

      @user = User.authenticate_with_credentials(' archiecohen@archiecohen.com ', "abc123")

      expect(@user).to_not be_nil
    end

    it "should allow users to log in even if random characters were capitalized" do
      user = User.create(first_name: "Archie", last_name: "Cohen", email: "archiecohen@archiecohen.com", password: "abc123", password_confirmation: "abc123")
      

      @user = User.authenticate_with_credentials('ArChIeCoHeN@archIEcohen.com', "abc123")

      expect(@user).to_not be_nil
    end

  end

end
