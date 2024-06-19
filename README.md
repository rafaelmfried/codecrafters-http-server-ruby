[![progress-banner](https://backend.codecrafters.io/progress/http-server/c4f4e3e1-6bf1-45f3-b9e2-883570c9c144)](https://app.codecrafters.io/users/codecrafters-bot?r=2qF)

# Build Your Own HTTP Server in Ruby

Welcome to the "Build Your Own HTTP Server" challenge by Codecrafters! In this project, you will build an HTTP/1.1 server from scratch using Ruby. This challenge will teach you about TCP servers, HTTP request syntax, and more, while you build a fully functional web server capable of serving multiple clients.

## Project Structure

```
.
├── Gemfile
├── Gemfile.lock
├── README.md
├── app
│   ├── http_handler.rb
│   ├── http_headers.rb
│   ├── http_parser.rb
│   ├── http_request.rb
│   ├── http_response.rb
│   ├── http_server.rb
│   ├── http_status.rb
│   ├── logger.rb
│   ├── router.rb
│   ├── resources
│   │   ├── echo_resource.rb
│   │   ├── file_resource.rb
│   │   ├── root_resource.rb
│   │   ├── user_agent_resource.rb
│   └── server.rb
├── codecrafters.yml
└── your_server.sh
```

## Getting Started

### Prerequisites

Ensure you have Ruby (3.3) installed locally.

### Running the Server

The entry point for your HTTP server implementation is in `app/server.rb`. To run the server, use the provided script:

```sh
./your_server.sh
```
