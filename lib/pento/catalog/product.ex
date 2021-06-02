defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float
    field :image_upload, :string

    timestamps()
  end

  # FIXME: not matching on maps containing ONLY the unit_price
  # def changeset(product, attrs = %{unit_price: _unit_price}) do
  #   product
  #   |> cast(attrs, [:unit_price])
  #   |> validate_number(:unit_price, less_than: product.unit_price)
  #   |> unique_constraint(:sku)
  # end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> validate_number(:unit_price, greater_than: 0.0)
    |> unique_constraint(:sku)
  end
end
