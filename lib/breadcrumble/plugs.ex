defmodule Breadcrumble.Plugs do
  def add_breadcrumb(conn, opts) do
    breadcrumb = [name: opts[:name], url: opts[:url]]
    trail_index = opts[:index] || 0
    breadcrumb_trails = Map.get(conn.assigns, :breadcrumb_trails, [])
                        |> update_breadcrumb_trails trail_index, breadcrumb
    %{conn | assigns: Map.put(conn.assigns, :breadcrumb_trails, breadcrumb_trails)}
  end 

  defp update_breadcrumb_trails(breadcrumb_trails, index, breadcrumb) do
    breadcrumb_trail = Enum.at(breadcrumb_trails, index)
    case breadcrumb_trail do
      nil ->
        List.insert_at(breadcrumb_trails, index, [breadcrumb])
      _ ->
        List.replace_at(breadcrumb_trails, index, breadcrumb_trail ++ [breadcrumb])
    end
  end
end
