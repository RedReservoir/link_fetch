defmodule LinkFetch do
  @moduledoc """
  Simple module with the function asked in the exercice.
  """

  @doc """
  Returns a tuple with two lists containing the links on the img and anchor tags of the HTML document of the url.

  ## Examples

      iex> LinkFetch.fetch('https://www.newgrounds.com/')
      {["https://picon.ngfiles.com/758000/flash_758556.png?f1592892645",
        "https://picon.ngfiles.com/758000/flash_758415.png?f1592791808", ...],
       ["https://www.newgrounds.com/bbs/topic/1453142",
        "https://www.newgrounds.com/bbs/topic/1451785", ...}}
  """

  def fetch(url) do
    {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}} = :httpc.request(url)

    img_links = Regex.scan(~r/< *?img.*?>/, to_string(body)) |>
      Enum.map(fn txt -> Regex.run(~r/src= *?"http.*?"/, List.first(txt)) end) |>
      Enum.filter(fn txt -> !is_nil(txt) end) |>
      Enum.map(fn txt -> Regex.replace(~r/src= *?"/, List.first(txt), "") end) |>
      Enum.map(fn txt -> Regex.replace(~r/"/, txt, "") end)
    a_links = Regex.scan(~r/< *?a.*?>/, to_string(body)) |>
      Enum.map(fn txt -> Regex.run(~r/href= *?"http.*?"/, List.first(txt)) end) |>
      Enum.filter(fn txt -> !is_nil(txt) end) |>
      Enum.map(fn txt -> Regex.replace(~r/href= *?"/, List.first(txt), "") end) |>
      Enum.map(fn txt -> Regex.replace(~r/"/, txt, "") end)

    {img_links, a_links}
  end
end
