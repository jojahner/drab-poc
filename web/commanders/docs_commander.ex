defmodule DrabPoc.DocsCommander do
  require IEx
  require Logger

  use Drab.Commander, onload: :page_loaded, access_session: [:test]

  def qs_1_click(socket, _dom_sender) do
    val = socket |> select(:val, from: "#qs_1_text") |> inspect
    socket |> update(:text, set: val, on: "#qs_1_out")
  end

  def qs_2_click(socket, _dom_sender) do
    val = socket |> select(:text, from: ".qs_2") |> inspect
    socket |> update(:text, set: val, on: "#qs_2_out")
  end

  def qs_3_click(socket, _dom_sender) do
    attr = socket |> select(attr: "class", from: ".qs_2") |> inspect
    socket |> update(:text, set: attr, on: "#qs_3_out")
  end

  def qs_4_click(socket, _dom_sender) do
    css = socket |> select(css: "font", from: ".qs_2") |> inspect
    socket |> update(:text, set: css, on: "#qs_4_out")
  end

  def qs_5_click(socket, _dom_sender) do
    position = socket |> select(:position, from: ".qs_2") |> inspect
    socket |> update(:text, set: position, on: "#qs_5_out")
  end

  def qs_6_click(socket, _dom_sender) do
    w = socket |> select(:innerWidth, from: ".qs_2") |> inspect
    socket |> update(:text, set: w, on: "#qs_6_out")
  end

  def qs_7_click(socket, _dom_sender) do
    c = socket |> select(:classes, from: ".qs_2") |> inspect
    socket |> update(:text, set: c, on: "#qs_7_out")
  end

  def qu_1_click(socket, _dom_sender) do
    socket |> update(:text, set: "new <u>text</u>", on: "#qu_1_span")
  end

  def qu_2_click(socket, _dom_sender) do
    socket |> update(:html, set: "new <u>html</u>", on: "#qu_1_span")
  end

  def qu_3_click(socket, _dom_sender) do
    socket |> update(attr: "style", set: "font-family: monospace", on: "#qu_1_span")
  end

  def qu_4_click(socket, dom_sender) do
    socket |> update(class: "btn-primary", set: "btn-danger", on: this(dom_sender))
  end
  
  def qu_5_click(socket, dom_sender) do
    socket |> update(css: "border", set: "3px solid red", on: this(dom_sender))
  end

  def qu_6_click(socket, dom_sender) do
    socket |> update(:height, set: "66px", on: this(dom_sender))
  end

  def qu_7_click(socket, dom_sender) do
    socket |> update(:text, set: ["One", "Two", "Three"], on: this(dom_sender))
  end

  def qu_8_click(socket, dom_sender) do
    socket |> update(css: "font-size", set: ["8px", "10px", "12px", "14px"], on: this(dom_sender))
  end

  def qu_9_click(socket, dom_sender) do
    socket |> update(:class, set: ["btn-warning", "btn-primary", "btn-danger"], on: this(dom_sender))
  end

  def qu_10_click(socket, dom_sender) do
    socket |> update(:class, toggle: "btn-primary", on: this(dom_sender))
  end

  def qi_1_click(socket, _dom_sender) do
    socket |> insert(" <b>inserted</b> ", before: "#qi_1_span")

  end

  def qi_2_click(socket, _dom_sender) do
    socket |> insert(" <i>inserted</i> ", after: "#qi_1_span")
  end

  def qi_3_click(socket, _dom_sender) do
    socket |> insert(" <u>prepended</u> ", prepend: "#qi_1_span")
  end

  def qi_4_click(socket, _dom_sender) do
    socket |> insert(" <small>appended</small> ", append: "#qi_1_span")
  end

  def qd_1_click(socket, dom_sender) do
    socket |> delete(class: "btn btn-primary", from: this(dom_sender))
  end

  def qd_2_click(socket, _dom_sender) do
    socket |> delete(from: "#qd_2_pre")
  end

  def qd_3_click(socket, _dom_sender) do
    socket |> delete("#qd_3_pre")
  end

  def qe_1_click(socket, _dom_sender) do
    socket |> execute(:focus, on: "#qe_1_text")
  end

  def qe_2_click(socket, _dom_sender) do
    socket |> execute(:toggle, on: "#qe_1_text")
  end

  def a_1_click(socket, _dom_sender) do
    socket |> alert("Title", "Just a message")
    socket
  end

  def a_2_click(socket, dom_sender) do
    {button, _} =
      socket |> alert("Message", "What is the answer?", buttons: [ok: "42", cancel: "Don't know"])
    socket |> update(:text, set: "clicked #{button} button", on: this(dom_sender))
  end

  def a_3_click(socket, dom_sender) do
    form = "<input name='first' class='form-control'><input id='second' class='form-control'>"
    response = case socket |> alert("What's your name?", form, buttons: [ok: "A juści", cancel: "Poniechaj"]) do
      { :ok, params } -> "first is #{params["first"]}, and second: #{params["second"]}"
      { :cancel, _ }  -> "you cancelled!"
    end
    socket |> update(:text, set: response, on: this(dom_sender))
  end

  def a_4_click(socket, dom_sender) do
    {button, _} =
      socket |> alert("3 buttons", "Choice?", buttons: [ok: "Yes", cancel: "No", unspecified: "Don't know"])
    socket |> update(:text, set: "clicked #{button} button", on: this(dom_sender))
  end

  def a_5_click(socket, dom_sender) do
    {button, _} = socket |> alert("Timeout", "I will disapear in a few seconds", timeout: 5)
    socket |> update(:text, set: "clicked #{button} button", on: this(dom_sender))
  end

  def c_1_click(socket, dom_sender) do
    ret = socket |> execjs("2 + 2")
    socket |> update(:text, set: "Return value: #{ret}.", on: this(dom_sender))
  end

  def c_2_click(socket, _dom_sender) do
    _ = socket |> execjs("alert('Do you like alerts?')")
    socket
  end

  def c_3_click(socket, _dom_sender) do
    socket |> broadcastjs("console.log('message to all')")
  end

  def c_4_click(socket, _dom_sender) do
    socket |> put_store(:counter, get_store(socket, :counter, 0) + 1)
  end

  def c_5_click(socket, dom_sender) do
    counter = get_store(socket, :counter)
    socket |> update(:text, set: "get_store(:counter) returns: #{inspect(counter)}", on: this(dom_sender))
  end

  def c_6_click(socket, dom_sender) do
    test = get_session(socket, :test)
    socket |> update(:text, set: "get_session(:test) returns: #{inspect(test)}", on: this(dom_sender))
  end


  def page_loaded(socket) do
    socket
  end
end
