defmodule Cafeteria.Basket do
  @moduledoc """
  The main container to hold the status
  and products that are going to be
  checkout.
  """

  alias Cafeteria.Product
  alias Cafeteria.Store

  @type items :: %{
          String.t() => {Product.t(), quantity :: number()}
        }

  @type t :: %__MODULE__{
          id: String.t(),
          items: items(),
          status: :open | :closed
        }

  defstruct [:id, items: %{}, status: :open]

  @spec new :: t()
  def new do
    %__MODULE__{id: UUID.uuid1()}
  end

  @spec scan(t(), String.t()) :: {:ok, t()} | {:error, atom()}
  def scan(basket, product_code) do
    case Store.get_product(product_code) do
      {:ok, %Product{} = product} ->
        items = update_items(basket.items, product)

        basket = %__MODULE__{basket | items: items}
        {:ok, basket}

      error ->
        error
    end
  end

  # Internal Functions

  defp update_items(items, product) do
    item = update_item(items[product.code], product)
    Map.put(items, product.code, item)
  end

  defp update_item(nil, product), do: {product, 1}
  defp update_item({product, quantity}, _product), do: {product, quantity + 1}
end
