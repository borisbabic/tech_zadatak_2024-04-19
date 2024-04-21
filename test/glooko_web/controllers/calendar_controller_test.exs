defmodule GlookoWeb.CalendarControllerTest do
  use GlookoWeb.ConnCase
  import Glooko.DevicesFixtures
  import Glooko.AccountsFixtures

  describe "index" do
    test "daily_device_readings", %{conn: conn} do
      %{id: user_id} = user_fixture()

      %{device_id: device_id, timestamp: timestamp} =
        device_reading_fixture(%{}, %{user_id: user_id})

      expected_date = timestamp |> DateTime.to_date() |> Date.to_iso8601()
      conn = get(conn, ~p"/api/calendar/#{user_id}")

      assert %{"data" => [%{"date" => ^expected_date, "device_id" => ^device_id, "count" => 1}]} =
               json_response(conn, 200)
    end
  end
end
