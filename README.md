# Chatapp

chatapp is a real-time chat application built with the Phoenix Framework and Elixir. It features user authentication, channel management, and instant messaging using Phoenix LiveView and PubSub. This project is a great starting point for building scalable, interactive web applications with Elixir.

## Features

- Real-time chat with Phoenix LiveView
- User authentication (via Pow)
- Channel creation and management
- Persistent messages with PostgreSQL
- Responsive UI with Tailwind CSS

## Tech Stack

- **Elixir** & **Phoenix**: Backend and real-time features
- **Ecto**: Database wrapper and migrations
- **PostgreSQL**: Database
- **Pow**: User authentication
- **Tailwind CSS**: Frontend styling

## Getting Started

### Prerequisites
- Elixir ~> 1.14
- Erlang/OTP 25+
- PostgreSQL

### Setup
1. **Clone the repository:**
   ```sh
   git clone <repo-url>
   cd chatapp_new
   ```
2. **Install dependencies:**
   ```sh
   mix setup
   ```
3. **Setup the database:**
   ```sh
   mix ecto.setup
   ```
4. **Start the Phoenix server:**
   ```sh
   mix phx.server
   # or with IEx
   iex -S mix phx.server
   ```
5. **Visit [`localhost:4000`](http://localhost:4000) in your browser.**

## Production Deployment
For deploying to production, see the [Phoenix deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn More
- [Phoenix Framework](https://www.phoenixframework.org/)
- [Guides](https://hexdocs.pm/phoenix/overview.html)
- [Docs](https://hexdocs.pm/phoenix)
- [Elixir Forum](https://elixirforum.com/c/phoenix-forum)
- [Source](https://github.com/phoenixframework/phoenix)

## Contributing
Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License.

## Contact
For questions or support, please open an issue or reach out via the repository contact links.
