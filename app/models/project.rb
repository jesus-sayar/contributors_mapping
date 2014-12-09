class Project < ActiveRecord::Base
  # Accessors
  attr_accessor :contributors, :github_url
  
  # Validation
  validates :name, :username, :description, presence: true

  # Callbacks
  before_save :fetch_contributors_from_github
  after_save :upload_file_to_cartodb
  after_find :fetch_contributors_from_cartodb


  def fetch_contributors_from_github
    puts "Importing project from GitHub..."
    github = Github.new
    contributors_json = github.repos.contributors user: self.username, repo: self.name, per_page: 30, auto_pagination: true
    #uri = URI("https://api.github.com/repos/#{username}/#{name}/contributors?per_page=30&client_id=d136b27f555c1de4d80f&client_secret=5c4cb6ebeeb39e3064f09c870a0dc30e4b94f81a")
    #contributors_json = JSON.load(Net::HTTP.get(uri))
    self.contributors = []
    contributors_json.map do |contributor_json|
      contributor = Contributor.new(github_json: contributor_json)
      self.contributors << contributor if contributor.located?
    end
  end

  def upload_file_to_cartodb
    puts "Uploading data to CartoDB..."
    file_path = CartodbExporter.export(self)
    cartodb_service = Cartodb.new
    cartodb_service.upload_file(file_path)
  end

  def fetch_contributors_from_cartodb
    cartodb_service = Cartodb.new
    contributors_json = cartodb_service.get_table(cartodb_table_name)
    self.contributors = contributors_json.map do |contributor_json|
     Contributor.new(cartodb_json: contributor_json)
   end
  end

  def cartodb_table_name
    "#{self.username}_#{self.name}_contributors".downcase.parameterize.underscore
  end

  def contributions
    total_contributions = 0
    self.contributors.each do |cont|
      total_contributions += cont.contributions
    end
    total_contributions
  end

  def countries
    self.contributors.map(&:country).uniq.count
  end

  def states
    self.contributors.map(&:state).uniq.count
  end

  def cities
    contributors.map(&:city).uniq.count
  end
end