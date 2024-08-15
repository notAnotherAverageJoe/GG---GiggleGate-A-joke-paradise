# HiSinatra The GiggleGate

HiSinatra is a lightweight web application built with the Sinatra framework. It features user authentication, joke categories fetched from an external API, and the ability to save and manage favorite jokes. The project uses ActiveRecord for database management and BCrypt for secure password storage.

- Table of Contents
- Features
- Installation
- Usage
- Testing
- Configuration
- Contributing
- License
  Features
  User Authentication: Secure user registration and login using BCrypt.
  Session Management: User sessions with session secret for added security.
  Joke API Integration: Fetch programming, spooky, pun, and Christmas-themed jokes from a third-party API.
  Favorites Management: Users can save, view, and delete their favorite jokes.
  CRUD Operations: Full CRUD (Create, Read, Update, Delete) functionality for managing favorite jokes.
  Installation
  To set up the project locally, follow these steps:

Clone the repository:

```bash
git clone this repo
cd hisinatra
Install dependencies:
Ensure you have Ruby and Bundler installed. Then run:

bash
bundle install
Set up the database:
Configure your database in config/database.yml and run the following commands to set up the database:
```

```bash
rake db:create
rake db:migrate
Run the application:
Start the Sinatra server with:

bash
Copy code
ruby app.rb
Access the application:
Open your web browser and navigate to http://localhost:4567.
```

Usage
Routes
/: Home page.
/about: About page.
/joke: Fetches and displays a random programming joke.
/spooky: Fetches and displays a random spooky joke.
/pun: Fetches and displays a random pun joke.
/christmas: Fetches and displays a random Christmas joke.
/favorites: Displays the user's favorite jokes (requires login).
/register: User registration.
/login: User login.
/logout: Logs out the user.
Adding/Removing Favorites
Add a joke to favorites: After viewing a joke, use the form to save it to your favorites.
Delete a favorite joke: Go to the /favorites page and remove any joke by clicking the delete button.
