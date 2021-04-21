defmodule EthTransactCheckWeb.PageController do
  use EthTransactCheckWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
