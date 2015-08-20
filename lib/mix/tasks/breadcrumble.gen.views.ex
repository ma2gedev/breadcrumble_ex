defmodule Mix.Tasks.Breadcrumble.Gen.Views do
  use Mix.Task
  import Mix.Generator

  @shortdoc "Generates view and template for the Phoenix application"

  def run(args) do
    app_module = Mix.Project.config[:app] |> Atom.to_string |> Mix.Utils.camelize
    create_file Path.join(["web", "views", "breadcrumble_view.ex"])
                |> Path.relative_to(Mix.Project.app_path),
                view_template(app_module: app_module)
    create_file Path.join(["web", "templates", "breadcrumble", "breadcrumb.html.eex"])
                |> Path.relative_to(Mix.Project.app_path),
                breadcrumb_text
  end

  embed_template :view, """
  defmodule <%= @app_module %>.BreadcrumbleView do
    use <%= @app_module %>.Web, :view
  end
  """
  embed_text :breadcrumb, from_file("../../../../priv/templates/breadcrumb.html.eex")
end
