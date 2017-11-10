# Tapclicks::Api
A simple ruby wrapper for the Tapclicks API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tapclicks-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tapclicks-api

## Usage
Get all users:
   ```
      service = TapclicksApi::Users.new(client_id: CLIENT_ID, client_secret: SECRET)
      users = service.get
   ```
Get user by id
   ```
      user = service.get(ID)
   ```
Create user
    ```
      user = service.create(
          {
            "user_type": "agent",
            "email": "user@email.com",
            "password": "user1234",
            "first_name": "John",
            "last_name": "Doe",
            "reporting_profile_id": 1,
            "client_group_id": 1,
            "role_id": 1
          }
      )
    ```
## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
