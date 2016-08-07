require 'rails_helper'

RSpec.describe "user registration" do
  it "allows new users to register with an name email address and password" do
    visit "/users/sign_up"

    fill_in "Name",                 :with => "felipe"
    fill_in "Email",                 :with => "felipe@test.com"
    fill_in "Password",              :with => "123456"
    fill_in "Password confirmation", :with => "123456"

    click_button "Sign up"

    page.should have_content("Welcome! You have signed up successfully.")
  end
end