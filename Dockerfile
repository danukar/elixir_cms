# https://blog.lelonek.me/how-to-use-elixir-with-docker-836c9b4a25b0
FROM elixir:latest

# Install npm
RUN apt update -y
RUN apt install npm -y

# App root dir
WORKDIR /app

# Install hex
RUN mix local.hex --force

# Install rebar
RUN mix local.rebar --force

# Copy dependencies files
COPY mix.* ./

# following the instructions from ramansah/cms repo
RUN mix deps.get
RUN mix deps.compile

# Copy the app source
ADD . .

WORKDIR /app/assets
RUN npm install

WORKDIR /app
RUN chmod 744 ./start_server.sh
CMD ./start_server.sh
