namespace :projects do
  desc "Imports data and creates project"
  task :create_recommended, [:username, :repo] => :environment do |t, args|
    repo_json = import_project(args[:username], args[:repo])
    Project.create(username: args[:username], name: args[:repo], description: repo_json[:description])
  end

  def import_project(username, repo)
    puts "Importing #{username}/#{repo}"
    github = Github.new
    github.repos.get(user: username, repo: repo)
  end
end