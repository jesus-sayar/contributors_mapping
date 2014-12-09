require "rails_helper"

feature "User visits project" do
  scenario "successfully" do
    project = build(:project, name: "rails", username: "rails", description: "Ruby on Rails.")
    allow(Project).to receive(:find_by) { project }

    visit project_path(project.username, project.name)

    expect(page).to have_css "h2", text: "rails / rails"
  end
end