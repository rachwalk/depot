class CopyProductPriceToItem < ActiveRecord::Migration[6.1]
  def up
    add_column(:line_items, :price, :decimal, precision: 8, scale: 2)
    Cart.all.each do |cart|
      cart.line_items.each do |line_item|
        price = Product.find(line_item.product_id).price
        line_item.price = price
        line_item.save!
      end
    end
  end
  def down
    remove_column(:line_items, :price)
  end
end
