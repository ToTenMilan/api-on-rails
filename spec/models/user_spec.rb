require 'rails_helper'

RSpec.describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) } # like @user.email
  it { should respond_to(:password) } # like @user.password
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }

  it { should be_valid } # this method saves the @user setting it's id

  describe "when email is not present" do
    # without shoulda-matchers
    # before { @user.email = " " }
    # it { should_not be_valid }

    # methods added by shoulda-matchers
    it { should validate_presence_of(:email) }
  end

  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
  it { should validate_uniqueness_of(:auth_token) }


  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      # Devise.stub(:friendly_token).and_return("auniquetoken123") # imitate method friendly_token that returns some token
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end

end
