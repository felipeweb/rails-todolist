require 'rails_helper'

RSpec.describe "user sign in" do
  it "allows users to sign in after they have registered" do
    create(:user)

    visit "/users/sign_in"

    fill_in "Email",    :with => "felipe@teste.com"
    fill_in "Password", :with => "123456"

    click_button "Log in"

    page.should have_content("Signed in successfully.")
  end
end