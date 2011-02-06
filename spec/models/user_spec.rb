require 'spec_helper'

describe User do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com" }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name =>""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do 
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addrs = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addrs.each do |addr|
      valid_email_user = User.new(@attr.merge(:email => addr))
      valid_email_user.should be_valid
    end
  end
    
  it "should reject invalid email addresses" do
    addrs = %w[user@foo,com user_at_foo.org example.user@foo.]
    addrs.each do |addr|
      invalid_email_user = User.new(@attr.merge(:email => addr))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    # Put a user with to database !
    User.create!(@attr)
    user_dup_email = User.new(@attr)
    user_dup_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_dup_email = User.new(@attr)
    user_dup_email.should_not be_valid
  end
  
end




