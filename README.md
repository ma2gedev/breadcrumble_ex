# Breadcrumble

Elixir lang port of [Breadcrumble](https://github.com/ma2gedev/breadcrumble)

## Installation

```
# mix.exs
defp deps do
  [
    {:breadcrumble, "~> 1.0.0"}
  ]
end

# and fetch
$ mix deps.get
```

## Usage

```elixir
# example
# in a controller
defmodule SampleApp.PageController do
  use Breadcrumble

  plug :add_breadcrumb, name: 'breadcrumb1', url: '/page/1'
  plug :add_breadcrumb, name: 'breadcrumb2', url: '/page/2'

  def index(conn, _params) do
    add_breadcrumb(conn, name: 'breadcrumb3', url: '/page/3')
    |> render "breadcrumb.html"
  end
end

# `add_breadcrumb` function assigns a breadcrumb trails list to the `:breadcrumb_trails` key in the connection
# in a view
<%= for breadcrumb_trail <- @breadcrumb_trails do %>
  <%= for breadcrumb <- breadcrumb_trail do %>
    <a href="<%= breadcrumb[:url] %>"><%= breadcrumb[:name] %></a>
  <% end %>
<% end %>

# If you wish to know detail about view, see the example/template directory
```

```elixir
# multiple breadcrumb trails
# use :index option

plug :add_breadcrumb, name: 'breadcrumb_trail 1', url: '/page/1'

# this is same as the following
plug :add_breadcrumb, name: 'breadcrumb_trail 1', url: '/page/1', index: 1

# create a second trail
plug :add_breadcrumb, name: 'breadcrumb_trail 2', url: '/page/2', index: 2
```

## Usage for Phoenix application

```bash
$ mix breadcrumble.gen.views
* creating web/views/breadcrumble_view.ex
* creating web/templates/breadcrumble/breadcrumb.html.eex
```

```elixir
# web/web.ex
defmodule YourApp.Web do
  ...
  def controller do
    quote do
      ...
      use Breadcrumble  <= ADD
    end
  end
  ...
end

# add breadcrumb in controller
plug :add_breadcrumb, name: 'top', url: '/'

# render breadcrumb in template
<%= render YourApp.BreadcrumbleView, "breadcrumb.html", breadcrumb_trails: @breadcrumb_trails %>
```

## Requirements

[plug](https://github.com/elixir-lang/plug)

## License

MIT

