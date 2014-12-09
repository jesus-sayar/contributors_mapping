## Installation

Clone this project

```bash
git clone URL
cd contributors_mapping
bundle install
```
Configure GitHub API

You should configure github_client.rb initializer with your data.

```ruby
Github.configure do |c|
  c.basic_auth = "login:password"
end
```

Configure CartoDB API

You should configure cartodb_client.rb initializer with your data. You can visit [CartoDB docu](http://docs.cartodb.com/cartodb-platform/sql-api.html#api-key)
for get your API key.

```ruby
$cartodb_username = "username"
$cartodb_api_key = "your-api-key"
```

Create DB and run

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

## Testing

This project use RSpec and Capybara to run the tests. You can run the test with this command:

```bash
rspec spec 
```

## License

Contributors Mapping is distributed under the MIT License, copyright (c) 2014 Jesus Sayar Celestino
