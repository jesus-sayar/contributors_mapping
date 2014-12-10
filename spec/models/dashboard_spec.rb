require "rails_helper"

describe Dashboard do
  before(:each) do
    @fake_projects = 4.times.map do |t|
      build(:project, name: "dummy_repo_#{t}", 
      username: "dummy_user_#{t}", description: "dummy_description_#{t}")
    end
  end
  
  describe "#some_projects" do
    it "returns first half of all projects" do
      allow(Project).to receive(:all) { @fake_projects }

      dashboard = Dashboard.new
      expect(dashboard.some_projects).to eq [@fake_projects[0], @fake_projects[1]]
    end

    it "returns the remaining projects if the size is odd" do
      @fake_projects << build(:project, name: "dummy_repo_4", username: "dummy_user_4", description: "dummy_description_4")
      allow(Project).to receive(:all) { @fake_projects }

      dashboard = Dashboard.new
      expect(dashboard.some_projects).to eq [@fake_projects[0], @fake_projects[1], @fake_projects[2]]
    end

    it "returns empty array if there is not projects" do
      allow(Project).to receive(:all) { [] }

      dashboard = Dashboard.new
      expect(dashboard.some_projects).to eq []
    end
  end

  describe "#other_projects" do
    it "returns second half of all projects" do
      allow(Project).to receive(:all) { @fake_projects }

      dashboard = Dashboard.new
      expect(dashboard.other_projects).to eq [@fake_projects[2], @fake_projects[3]]
    end

    it "returns empty array if there is not projects" do
      allow(Project).to receive(:all) { [] }

      dashboard = Dashboard.new
      expect(dashboard.other_projects).to eq []
    end
  end
end