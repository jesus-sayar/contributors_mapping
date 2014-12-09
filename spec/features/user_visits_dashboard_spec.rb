require "rails_helper"

feature "User visits dashboard" do
  scenario "successfully" do
    visit root_path

    expect(page).to have_css "h1", text: "Contributors Mapping"
  end
end