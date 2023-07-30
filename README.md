# Cafeteria

This is an example app to checkout a shopping basket and taking into account product discounts.

## Usage

### Products

No database is used for the current version and reading products is the only operation available
in the `Cafeteria.Product` store.

A product has the following structure:

```elixir
  %Product{
    code: String.t(),
    name: String.t(),
    price: Coin.t()
 }
```

### Discount Rules

Some discount rules are predefined and attached the existing products. It is possible
to add new discount rules or modify the existent ones via via `PricingStore.add_discount_rule/2`.

Three types of discount rules are available which can be defined as follows:

- Pay x get y -> type: free_items

```elixir
    %{type: :free_items, pay: 1, get: 1}
```

- Bulk discount with fixed price -> type: bulk_fixed

```elixir
  %{type: :bulk_fixed, min_quantity: 3, new_price: Coin.new("4.50")}
```

- Bulk discount with percentage / rate -> type: bulk_rate

```elixir
  # Discount of 10%
  %{type: :bulk_rate, min_quantity: 3, rate: 0.1}
```


### Checkout Process

To star the checkout process it is required to create a new shopping basket.

```elixir
iex(1)> basket = Cafeteria.create_basket()
```

Add new products to the existing basket, scanning them by code.

```elixir
iex(2)> basket = Cafeteria.scan_product(basket, "GR1")

{:ok,
 %Cafeteria.Basket{
   id: "4766e064-2ef8-11ee-b6a8-7e52309de6ad",
   items: %{
     "GR1" => {%Cafeteria.Product{
        code: "GR1",
        name: "Green tea",
        price: %Cafeteria.Coin{amount: Decimal.new("3.11"), currency: :GBP}
      }, 1}
   },
   status: :open
 }}
```

Finally, checkout the order in process to get the total price with the discounts
applied if the provided rules matched.


```elixir
iex(3)> pricing_rules = Cafeteria.PricingStore.get_discount_rules()
iex(4)> Cafeteria.basket_checkout(basket, pricing_rules)

%Cafeteria.Coin{amount: Decimal.new("3.11"), currency: :GBP}
```

## License

MIT License please see the LICENSE.md file.
