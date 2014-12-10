# Contributors Mapping

[![Code Climate](https://codeclimate.com/github/jesus-sayar/contributors_mapping/badges/gpa.svg)](https://codeclimate.com/github/jesus-sayar/contributors_mapping)

Contributors Mapping is a analytic and visualization web about Open Source projects. Using GitHub API and CartoDB scans open source projects, allowing you to discover where live the contributors and that world zones are more active.

## Installation

Clone this project and install its gems:

```bash
git clone URL
cd contributors_mapping
bundle install
```

Configure the GitHub API client updating github_client.rb initializer with your data:

```ruby
Github.configure do |c|
  c.basic_auth = "login:password"
end
```

Configure the CartoDB API client updating cartodb_client.rb initializer with your data. You can visit [CartoDB documentation](http://docs.cartodb.com/cartodb-platform/sql-api.html#api-key) for get your API key:

```ruby
$cartodb_username = "username"
$cartodb_api_key = "your-api-key"
```

Create DB and run the server:

```bash
rake db:setup
rails s
```

## Getting Started

Run the next task for create a new project and import its data.

```bash
rake projects:create_recommended[username,repo]
```

For example you can import the Rails data running:

```bash
rake projects:create_recommended["rails","rails"]
```

Now you can browse in the project and you see a new map visualization with this data.

## Architecture

Contributors Mapping consult GitHub API for fetch data about a Open Source project and its contributors. Upload this data to CartoDB cloud and then create analytics and visualizations.

GitHub and CartoDB API's have restrictions on the number of daily calls. You can create some project analytics, but if you need consult many projects you will need hire advanced subscriptions on this services.

## Testing

This project use RSpec and Capybara to run the tests. You can run the test with this command:

```bash
rspec spec 
```

## License

Contributors Mapping is distributed under the MIT License, copyright (c) 2014 Jesus Sayar Celestino