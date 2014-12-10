require "rails_helper"

describe Project do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:description) }

  describe "#top_contributors" do
    it "returns top ten contributors ordered by number of contributions" do
      project = build(:project)
      best_contributor = build(:best_contributor)
      middle_contributor = build(:middle_contributor)
      worst_contributor = build(:worst_contributor)

      allow(project).to receive(:contributors) { [best_contributor, middle_contributor, worst_contributor] }

      expect(project.top_contributors).to eq [best_contributor, middle_contributor, worst_contributor]
    end
  end

  describe "#top_countries" do
    it "returns top ten countries ordered by number or contributions" do
      project = build(:project)
      allow(project).to receive(:contributors) do 
        [build(:contributor, contributions: 50, country: "United States"),
         build(:contributor, contributions: 100, country: "Spain"),
         build(:contributor, contributions: 5, country: "Germany"),
         build(:contributor, contributions: 25, country: "United States"),
         build(:contributor, contributions: 75, country: "Spain")]
      end

      result = [{country: "Spain", contributions: 175},
                {country: "United States", contributions: 75},
                {country: "Germany", contributions: 5}]
      (0..2).each do |i|
        expect(project.top_countries[i][:country]).to eq result[i][:country]
        expect(project.top_countries[i][:contributions]).to eq result[i][:contributions]
      end
    end
  end

  describe "#top_states" do
    it "returns top ten states ordered by number or contributions" do
      project = build(:project)
      allow(project).to receive(:contributors) do 
        [build(:contributor, contributions: 5, state: "Barcelona"),
         build(:contributor, contributions: 75, state: "Pontevedra"),
         build(:contributor, contributions: 50, state: "Madrid"),
         build(:contributor, contributions: 25, state: "Madrid"),
         build(:contributor, contributions: 100, state: "Pontevedra")]
      end

      result = [{state: "Pontevedra", contributions: 175},
                {state: "Madrid", contributions: 75},
                {state: "Barcelona", contributions: 5}]
      (0..2).each do |i|
        expect(project.top_states[i][:state]).to eq result[i][:state]
        expect(project.top_states[i][:contributions]).to eq result[i][:contributions]
      end
    end
  end
end