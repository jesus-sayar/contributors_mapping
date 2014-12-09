require "rails_helper"

feature "Dashboard shows projects" do
  scenario "successfully" do
    project1 = build(:project, name: "rails", username: "rails", description: "Ruby on Rails.")
    project2 = build(:project, name: "spree", username: "spree", description: "Spree is a complete open source e-commerce solution for Ruby on Rails.")
    project3 = build(:project, name: "factory_girl", username: "thoughtbot", description: "A library for setting up Ruby objects as test data.")
    allow(Project).to receive(:all) { [project1, project2, project3] }

    visit dashboard_path

    expect(page).to have_css ".projects a", text: "rails / rails"
    expect(page).to have_css ".projects a", text: "spree / spree"
    expect(page).to have_css ".projects a", text: "thoughtbot / factory_girl"
  end

  scenario "Not exists projects" do
    visit dashboard_path

    expect(page).to have_css "p", text: "There is no projects yet."
  end
end
