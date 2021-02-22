require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title:  "My Book Title",
                          description: "yyy",
                          image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 1
    assert product.valid?
  end
  
  def new_product(image_url)
    Product.new(title:  "My Book Title",
                description: "yyy",
                price: 1,
                image_url: image_url)
  end

  test "image url" do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |img_url|
      assert new_product(img_url).valid?,
        "#{img_url} shouldn't be invalid"
    end
    bad.each do |img_url|
      assert new_product(img_url).invalid?,
        "#{img_url} shouldn't be valid"
    end
  end

  test "product is not valid without unique title" do
    product = Product.new(title: products(:ruby).title,
                         description: "yyy",
                         price: 1,
                         image_url: "fred.gif")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  def new_product_2(title)
    Product.new(title:  title,
                description: "yyy",
                price: 1,
                image_url: "fred.gif")
  end

  test "product is not valid with title shorter than 10 characters" do
    product = new_product_2("short")
    assert product.invalid?
    assert_equal ["must be at least 10 chars!"], product.errors[:title]

    product = new_product_2("1234567890")
    assert product.valid?

    product = new_product_2("This is a very long title")
    assert product.valid?
  end


end
