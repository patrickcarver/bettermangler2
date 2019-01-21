# BetterMangler

**Usage**

This is currently a work in progress.

Clone this repository and from your local directory, run this command:

```elixir
iex -S mix
```

Then run:

```elixir
pid = BetterMangler.start_link
```

You can then use that pid to create get a word's "defintion"

```elixir
BetterMangler(pid, "elixir")
```
