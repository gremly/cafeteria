defmodule Cafeteria.Coin do
  @module """
  Module to perform money operation with decimals.
  """

  alias Decimal

  @type t :: %__MODULE__{
          amount: Decimal.t(),
          currency: atom()
        }

  defstruct amount: Decimal.new("0"), currency: :GBP

  @spec new(String.t()) :: t()
  def new(amount, currency \\ :GBP) do
    %__MODULE__{amount: Decimal.new(amount), currency: currency}
  end

  @spec add(t(), t()) :: t()
  def add(%__MODULE__{amount: amount_a}, %__MODULE__{amount: amount_b}) do
    %__MODULE__{amount: Decimal.add(amount_a, amount_b)}
  end

  @spec sub(t(), t()) :: t()
  def sub(%__MODULE__{amount: amount_a}, %__MODULE__{amount: amount_b}) do
    %__MODULE__{amount: Decimal.sub(amount_a, amount_b)}
  end

  def sub(%__MODULE__{amount: amount_a}, amount_b) do
    %__MODULE__{amount: Decimal.sub(amount_a, amount_b)}
  end

  def mult(%__MODULE__{amount: amount_a}, %__MODULE__{amount: amount_b}) do
    %__MODULE__{amount: Decimal.mult(amount_a, amount_b)}
  end

  def mult(%__MODULE__{amount: amount_a}, amount_b) when is_float(amount_b) do
    %__MODULE__{amount: Decimal.mult(amount_a, Decimal.from_float(amount_b))}
  end

  def mult(amount_a, %__MODULE__{amount: amount_b}) when is_float(amount_a) do
    %__MODULE__{amount: Decimal.mult(Decimal.from_float(amount_a), amount_b)}
  end

  def mult(%__MODULE__{amount: amount_a}, amount_b) do
    %__MODULE__{amount: Decimal.mult(amount_a, amount_b)}
  end

  def mult(amount_a, %__MODULE__{amount: amount_b}) do
    %__MODULE__{amount: Decimal.mult(amount_a, amount_b)}
  end

  @spec round(t(), Integer.t(), atom()) :: Decimal.t()
  def round(%__MODULE__{amount: amount}, digits \\ 0, mode \\ :half_up) do
    new(Decimal.round(amount, digits, mode))
  end
end
