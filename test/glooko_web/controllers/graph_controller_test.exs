defmodule GlookoWeb.GraphControllerTest do
  use GlookoWeb.ConnCase
  import Glooko.DevicesFixtures
  import Glooko.AccountsFixtures

  test "invalid date range returns error", %{conn: conn} do
    %{id: user_id} = user_fixture()

    device_reading_fixture(%{}, %{user_id: user_id})
    conn = get(conn, ~p"/api/graph/#{user_id}?start_date=1970-01-01")
    assert %{"error" => %{"slug" => "invalid_date_range"}} = json_response(conn, 400)
  end

  test "user device readings", %{conn: conn} do
    %{id: user_id} = user_fixture()

    %{device_id: device_id, timestamp: timestamp, glucose_value: value} =
      device_reading_fixture(%{timestamp: DateTime.utc_now()}, %{user_id: user_id})

    conn = get(conn, ~p"/api/graph/#{user_id}")
    string_timestamp = DateTime.to_iso8601(timestamp)

    assert %{
             "data" => [
               %{
                 "device_id" => ^device_id,
                 "timestamp" => ^string_timestamp,
                 "glucose_value" => ^value
               }
             ]
           } = json_response(conn, 200)
  end
end
