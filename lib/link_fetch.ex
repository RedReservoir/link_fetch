defmodule LinkFetch do
  @moduledoc """
  Simple module with the fetch function asked in the exercice.
  """

  @doc """
  Returns all links in image and anchor tags from an HTML.

  ## Examples

      iex> LinkFetch.fetch('https://www.newgrounds.com/')
      {:ok,
       {["https://picon.ngfiles.com/758000/flash_758556.png?f1592892645",
        "https://picon.ngfiles.com/758000/flash_758415.png?f1592791808", ...],
       ["https://www.newgrounds.com/bbs/topic/1453142",
        "https://www.newgrounds.com/bbs/topic/1451785", ...]}}
  """

  def fetch(url) do
    {result, return_data} = :httpc.request(url)

    case result do
      :error ->
        {result, return_data}

      :ok ->
        {_response, _headers, body} = return_data
        
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

        {result, {img_links, a_links}}
    end
  end

end
