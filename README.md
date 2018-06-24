# Identicon

Just following the course on udemy.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `identicon` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:identicon, "~> 0.1.0"}
  ]
end
```

## Usage

```
iex> Identicon.main("test1")
:ok
```
![Output Example](https://github.com/dan1d/identicon/raw/master/test1.png)

```
iex> Identicon.main("test2")
:ok
```
![Output Example](https://github.com/dan1d/identicon/raw/master/test2.png)


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/identicon](https://hexdocs.pm/identicon).
