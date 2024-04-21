defmodule Glooko.Error do
  @moduledoc false

  @type t :: %{slug: atom(), message: String.t(), code: integer()}
  @derive {Jason.Encoder, except: [:code]}
  defstruct slug: :unknown_error, message: "An error happened", code: 500

  @type parsable_error :: atom() | String.t() | %{message: String.t(), slug: atom() | String.t()}
  @spec new(parsable_error | any() | {:error, parsable_error() | any()}) :: __MODULE__.t()
  def new({:error, error}) do
    new(error)
  end

  def new(%__MODULE__{} = error), do: error

  def new(error) when is_atom(error) do
    %__MODULE__{slug: error, message: to_string(error)}
  end

  def new(error) when is_binary(error) do
    %__MODULE__{message: error}
  end

  def new(_), do: %__MODULE__{}
end
