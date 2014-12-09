FactoryGirl.define do
  factory :project do
    name "Dummy project"
    username "Dummy user"
    description "This is a dummy project."
    after(:build) do |project|
      project.contributors = []
      5.times { project.contributors << FactoryGirl.build(:contributor) }
    end
  end
end