require 'rails_helper'

RSpec.describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) } # like @user.email
  it { should respond_to(:password) } # like @user.password
  it { should respond_to(:password_confirmation) }

  it { should be_valid } # this method saves the @user setting it's id

  describe "when email is not present" do
    # without shoulda-matchers
    # before { @user.email = " " }
    # it { should_not be_valid }

    # methods added by shoulda-matchers
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_confirmation_of(:password) }
    it { should allow_value('example@domain.com').for(:email) }
  end

end
