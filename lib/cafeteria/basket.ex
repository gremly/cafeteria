defmodule Cafeteria.Basket do
  @moduledoc """
  The main container to hold the status of
  the order while is created.
  """

  alias Cafeteria.Coin
  alias Cafeteria.Product

  @type t :: %__MODULE__{
          id: String.t(),
          products: [Product.t()],
          status: :open | :closed
        }

  defstruct [:id, products: [], status: :open]

  @spec new :: t()
  def new do
    %__MODULE__{id: UUID.uuid1()}
  end

  @spec scan(t(), String.t()) :: {:ok, t()} | {:error, atom()}
  def scan(basket, product_code) do
    case get_product(product_code) do
      {:ok, product} ->
        basket = %__MODULE__{basket | products: [product | basket.products]}
        {:ok, basket}

      error ->
        error
    end
  end

  # Internal Functions

  defp get_product(product_code) do
    product_store = %{
      "GR1" => %Product{
        code: "GR1",
        name: "Green tea",
        price: %Coin{amount: 3.11, currency: "GBP"}
      }
    }

    case product_store[product_code] do
      nil -> {:error, :product_not_found}
      product -> {:ok, product}
    end
  end
end
