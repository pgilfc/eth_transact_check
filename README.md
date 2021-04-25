# EthTransactCheck

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

The approach applied uses etherscan's api. Which implies:

  * There is an api rate limit. Which was managed through a GenServer.
  * Transaction validation is not done at the user input level (only a regex validation is done), because the api's rate limit would burst with many users using it simultaneously. 
  * There is a database (postgres) that stores the transactions and its state.
  * There are two automated cron tasks running with the application. These tasks are responsible for checking the status of the transaction and if it has at least two block confirmations. 
  * When launching the application, an api key for the etherscan api is required.

Future improvements:

  * Using Ethereumex with a HTTP-RPC node would possibly avoid the etherscan's api rate limits (wich would possibly allow live transaction validation), this would however require a node running on a server.
  * Old (invalid) transaction clean up would probably be a nice improvement.

