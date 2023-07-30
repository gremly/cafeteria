defmodule Cafeteria.Store do
  @moduledoc """
  This module simulates an external storage
  used to manage the product inventory.

  The availability checks and product management
  are most likely implemented in another service.
  """

  alias Cafeteria.Coin
  alias Cafeteria.Product

  @products %{
    "GR1" => %Product{
      code: "GR1",
      name: "Green tea",
      price: Coin.new("3.11")
    },
    "SR1" => %Product{
      code: "SR1",
      name: "Strawberries",
      price: Coin.new("5.00")
    },
    "CF1" => %Product{
      code: "CF1",
      name: "Coffee",
      price: Coin.new("11.23")
    }
  }

  @spec get_product(String.t()) :: {:ok, Product.t()} | {:error, :product_not_found}
  def get_product(product_code) do
    case @products[product_code] do
      nil -> {:error, :product_not_found}
      product -> {:ok, product}
    end
  end
end
