defmodule DrabPoc.DocsController do
  use DrabPoc.Web, :controller
  use Drab.Controller #, commander: DrabPoc.PageCommander

  def index(conn, _params) do
    render conn, "index.html"
  end
end
