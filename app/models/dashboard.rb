class Dashboard
  attr_accessor :all_projects, :some_projects, :other_projects

  def initialize
    @all_projects = Project.all
    @some_projects, @other_projects = @all_projects.each_slice(2).to_a
  end

  def some_projects
    @some_projects ? @some_projects : []
  end

  def other_projects
    @other_projects ? @other_projects : []
  end
end