# Sinatra Wordle

A Ruby implementation of the popular word-guessing game Wordle, built with Sinatra and SQLite.

## 🎮 Game Rules

- Guess the 5-letter word in 6 attempts or fewer
- After each guess, you'll get color-coded feedback:
  - 🟩 Green: Letters are correct and in the right position
  - 🟨 Yellow: Letters are in the word but in the wrong position
  - ⬜ Gray: Letter is not in the word

## 🚀 Features

- Clean, responsive UI
- Real-time feedback on guesses
- SQLite database for word storage
- Session management for game state
- Input validation
- Mobile-friendly design

## 🛠️ Technology Stack

- Ruby 3.3.6
- Sinatra web framework
- SQLite3 database
- ActiveRecord ORM
- RSpec for testing

## 📋 Prerequisites

- Ruby 3.3.6
- SQLite3
- Bundler

## 🔧 Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/sinatra-wordle.git
cd sinatra-wordle
```

2. Install dependencies:
```bash
bundle install
```

3. Set up the database:
```bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

4. Start the server:
```bash
ruby app.rb
```

5. Visit `http://localhost:4567` in your browser

## 🧪 Running Tests

Run the test suite with:
```bash
bundle exec rspec
```

## 📝 Database Schema

The application uses two main tables:

### Words Table
- `text`: The 5-letter word (unique, required)
- Timestamps

### Games Table
- `word_id`: Reference to the target word
- `guesses`: Serialized array of guess attempts
- `completed`: Game completion status
- Timestamps

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Inspired by the original [Wordle](https://www.nytimes.com/games/wordle/index.html) game
- Word list curated from common English 5-letter words

## 🔍 Code Structure

The application follows a standard Sinatra structure:
- `app.rb`: Main application file
- `models/`: ActiveRecord models
- `views/`: ERB templates
- `db/`: Database migrations and seeds
- `spec/`: Test files
- `public/`: Static assets

## 🌐 Deployment

The application is ready for deployment on any platform that supports Ruby applications. Make sure to:

1. Set appropriate environment variables
2. Run database migrations
3. Seed the word database
4. Configure your web server (e.g., Puma, Unicorn)

For example, to deploy on Heroku:
```bash
heroku create
git push heroku main
heroku run rake db:migrate
heroku run rake db:seed
```
