require "rails_helper"

feature "Admin login" do
  scenario "successfully" do
    user_admin = AdminUser.create(email: "admin@contributors_mapping.com", password: "abc123", password_confirmation: "abc123")
    
    visit "/admin"
    fill_in "Email", with: "admin@contributors_mapping.com"
    fill_in "Password", with: "abc123"
    click_on "Login"
    
    expect(page).to have_css "h1", text: "Contributors Mapping Administration"
  end

  scenario "invalid data" do
    user_admin = AdminUser.create(email: "admin@contributors_mapping.com", password: "abc123", password_confirmation: "abc123")
    
    visit "/admin"
    fill_in "Email", with: "admin@contributors_mapping.com"
    fill_in "Password", with: ""
    click_on "Login"

    expect(page).to have_content "Invalid email or password."
  end
end