defmodule BreadcrumbleTest do
  use Breadcrumble
  use ExUnit.Case, async: true
  use Plug.Test

  require Logger

  test "it adds a breadcrumb" do
    conn = conn(:get, "/")
    conn = add_breadcrumb conn, name: "name1", url: "/url1"
    assert Map.get(conn.assigns, :breadcrumb_trails) == [[[name: "name1", url: "/url1"]]]

    conn = add_breadcrumb conn, name: "name2", url: "/url2"
    assert Map.get(conn.assigns, :breadcrumb_trails) == [[[name: "name1", url: "/url1"], [name: "name2", url: "/url2"]]]
  end

  test "it adds a breadcrumb trails" do
    conn = conn(:get, "/")
    conn = add_breadcrumb conn, name: "name10", url: "/url10"
    assert Map.get(conn.assigns, :breadcrumb_trails) == [[[name: "name10", url: "/url10"]]]

    conn = add_breadcrumb conn, name: "name20", url: "/url20", index: 1
    assert Map.get(conn.assigns, :breadcrumb_trails) == [[[name: "name10", url: "/url10"]], [[name: "name20", url: "/url20"]]]

    conn = add_breadcrumb conn, name: "name11", url: "/url11"
    assert Map.get(conn.assigns, :breadcrumb_trails) == [[[name: "name10", url: "/url10"], [name: "name11", url: "/url11"]], [[name: "name20", url: "/url20"]]]

    conn = add_breadcrumb conn, name: "name21", url: "/url21", index: 1
    assert Map.get(conn.assigns, :breadcrumb_trails) == [[[name: "name10", url: "/url10"], [name: "name11", url: "/url11"]], [[name: "name20", url: "/url20"], [name: "name21", url: "/url21"]]]
  end
end
