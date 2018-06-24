# Intro
Identicon is a an Elixir library that can be used to generate an image with a provided string.


### Why Elixir?
From the Elixir website -
> Elixir is a dynamic, functional language designed for building scalable and
maintainable applications.

> Elixir leverages the Erlang VM, known for running low-latency, distributed and
fault-tolerant systems, while also being successfully used in web development
and the embedded software domain.

### Usage

```Elixir
def deps do
  [{:identicon, git: "https://github.com/dan1d/identicon.git"}]
end
```

```
iex> Identicon.main("test1")
:ok
```
![Output](https://raw.githubusercontent.com/dan1d/identicon/master/identicon/test1.png )
