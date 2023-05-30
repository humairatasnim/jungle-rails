require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'validates user if all details are set' do
      @user = User.create(
        first_name: 'first',
        last_name: 'last',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to be_valid
    end
    
    it 'validates password and password confirmation are set' do
      @user = User.create(
        first_name: 'first',
        last_name: 'last',
        email: 'user@email.com',
        password: nil,
        password_confirmation: nil
      )
      expect(@user).to_not be_valid
    end

    it 'validates if password and password confirmation are same' do
      @user = User.create(
        first_name: 'first',
        last_name: 'last',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'passcode'
      )
      expect(@user).to_not be_valid
    end

    it 'validates if email already exists' do
      @user1 = User.create(
        first_name: 'first',
        last_name: 'last',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user2 = User.create(
        first_name: 'first',
        last_name: 'last',
        email: 'User@Email.Com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user2).to_not be_valid
    end

    it 'validates email' do
      @user = User.create(
        first_name: 'first',
        last_name: 'last',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it 'validates first name' do
      @user = User.create(
        first_name: nil,
        last_name: 'last',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it 'validates last name' do
      @user = User.create(
        first_name: 'first',
        last_name: nil,
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end

    it 'validates length of password' do
      @user = User.new(
        first_name: 'first',
        last_name: 'last',
        email: 'user@email.com',
        password: '123',
        password_confirmation: '123'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 4 characters)")
    end

  end

  describe '.authenticate_with_credentials' do

    it 'validates email with additional spaces' do
      @user = User.create(
        first_name: 'first',
        last_name: 'last',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(User.authenticate_with_credentials(' user@email.com ', 'password')).to eq(@user)
    end

    it 'validates email with different case' do
      @user = User.create(
        first_name: 'first',
        last_name: 'last',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(User.authenticate_with_credentials('User@Email.Com', 'password')).to eq(@user)
    end

  end
end
