require 'geocoder'

class Contributor

  attr_accessor :id, :username, :contributions, :avatar_url, :name, :email, :bio, :location, :latitude, :longitude, :country, :state, :city

  def initialize(options = {})
    if options[:github_json].present?
      initialize_with_github_json(options[:github_json])
    elsif options[:cartodb_json].present?
      initialize_with_cartodb_json(options[:cartodb_json])
    end
  end

  def github_url
    "https://github.com/#{@username}"
  end

  def located?
    @location.present? and @latitude.present? and @longitude.present?
  end

  private
    def initialize_with_github_json(contributor_json)
      @id = contributor_json[:id]
      @username = contributor_json[:login]
      @contributions = contributor_json[:contributions]
      @avatar_url = contributor_json[:avatar_url]
      fetch_aditional_info_from_github
    end

    def fetch_aditional_info_from_github
      puts "Importing user data of #{@username}..."
      github = Github.new
      user_json = github.users.get user: @username
      #uri = URI("https://api.github.com//users/#{@username}&client_id=d136b27f555c1de4d80f&client_secret=5c4cb6ebeeb39e3064f09c870a0dc30e4b94f81a")
      #user_json = JSON.load(Net::HTTP.get(uri))
      @name = user_json[:name]
      @email = user_json[:email]
      @bio = user_json[:bio]
      @location = user_json[:location]
      if @location.present?
        result = Geocoder.search(@location).first
        if result
          @latitude, @longitude = result.coordinates
          @country = result.country
          @state = result.state
          @city = result.city
        end
      end
    end

    def initialize_with_cartodb_json(contributor_json)
      @id = contributor_json["id"]
      @username = contributor_json["username"]
      @contributions = contributor_json["contributions"]
      @avatar_url = contributor_json["avatar_url"]
      @name = contributor_json["name"]
      @email = contributor_json["email"]
      @bio = contributor_json["bio"]
      @location = contributor_json["location"]
      @latitude = contributor_json["latitude"]
      @longitude = contributor_json["longitude"]
      @country = contributor_json["country"]
      @state = contributor_json["state"]
      @city = contributor_json["city"]
    end
end