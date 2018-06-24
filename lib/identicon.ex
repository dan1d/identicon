defmodule Identicon do

  @doc """
    Creates an image icon based on a string, it hashes the string and based on that hash it produces the same output for the same input.


  ## Examples

    iex> Identicon.main("test1")
    :ok

    iex> Identicon.main("test2")
    :ok

  """

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odds_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color({color.red, color.green, color.blue})
    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end
    :egd.render(image)
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn {_code, index} ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}
      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odds_squares(%Identicon.Image{grid: grid} = image) do
    odds = Enum.filter grid,
      fn({code, _tail}) ->
        rem(code, 2) == 0
      end
    %Identicon.Image{image | grid: odds}
  end

  @doc """
    it has an strign and returns a list of binaries

  ## Examples

    iex> input1 = Identicon.hash_input "banana"
    %Identicon.Image{
      hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65],
      color: %{},
      grid: nil
    }
    iex> input2 = Identicon.hash_input "banana"
    iex> input1.hex == input2.hex
    true

  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  @doc """
    It pick a color in RGB format and adds it to the `Identicon.Image` struct.

  ## Examples

    iex> Identicon.pick_color(Identicon.hash_input("banana"))
    %Identicon.Image{
      hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65],
      color: %{ red: 114, green: 179, blue: 2 },
      grid: nil
    }

  """

  def pick_color(%Identicon.Image{hex: [r,g,b | _tail]} = image) do
    %Identicon.Image{image | color: %{ red: r, green: g, blue: b }}
  end

  @doc """
    Creates a grid

  ## Examples

    iex> image = Identicon.main("banana")
    iex> image.grid
    [
      {114, 0},
      {179, 1},
      {2, 2},
      {179, 3},
      {114, 4},
      {191, 5},
      {41, 6},
      {122, 7},
      {41, 8},
      {191, 9},
      {34, 10},
      {138, 11},
      {117, 12},
      {138, 13},
      {34, 14},
      {115, 15},
      {1, 16},
      {35, 17},
      {1, 18},
      {115, 19},
      {239, 20},
      {239, 21},
      {124, 22},
      {239, 23},
      {239, 24}
    ]

  """

  def build_grid(%Identicon.Image{hex: hex } = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirrow_row/1)
      |> List.flatten
      |> Enum.with_index
    %Identicon.Image{image | grid: grid}
  end

  @doc """
    Mirrows a row

  ## Examples

    iex> Identicon.mirrow_row([1,2,3])
    [1,2,3,2,1]

  """

  def mirrow_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end
end
