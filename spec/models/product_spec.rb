require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryGirl.build :product }
  subject { product }

  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:published) }
  it { should respond_to(:user_id) }

  it { should_not be_published }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:user_id) }

  it { should belong_to(:user)}

  it { should have_many(:placements) }
  it { should have_many(:orders).through(:placements) }

  ################### book version #######################
  # describe ".filter_by_title" do
  #   before(:each) do
  #     @product1 = FactoryGirl.create :product, title: "A plasma TV"
  #     @product2 = FactoryGirl.create :product, title: "Fastest laptop"
  #     @product3 = FactoryGirl.create :product, title: "CD player"
  #     @product4 = FactoryGirl.create :product, title: "LCD TV"
  #   end

  #   context "when a 'TV' title pattern is sent" do
  #     it "returns the 2 products matching" do
  #       expect(Product.filter_by_title("TV")).to have(2).items
  #     end

  #     it "returns the products matching" do
  #       expect(Product.filter_by_title("TV").sort).to match_array([@product1, @product4])
  #     end
  #   end
  # end

  # describe ".above_or_equal_to_price" do
  #   before(:each) do
  #     @product1 = FactoryGirl.create :product, price: 100
  #     @product2 = FactoryGirl.create :product, price: 50
  #     @product3 = FactoryGirl.create :product, price: 150
  #     @product4 = FactoryGirl.create :product, price: 99
  #   end

  #   it "returns the products which are qbove or equal to the price" do
  #     expect(Product.above_or_equal_to_price(100).sort).to match_array([@product1, @product3])
  #   end
  # end

  # describe ".below_or_equal_to_price" do
  #   before(:each) do
  #     @product1 = FactoryGirl.create :product, price: 100
  #     @product2 = FactoryGirl.create :product, price: 50
  #     @product3 = FactoryGirl.create :product, price: 150
  #     @product4 = FactoryGirl.create :product, price: 99
  #   end

  #   it "returns the products which are below or equal to price" do
  #     expect(Product.below_or_equal_to_price(99).sort).to match_array([@product2, @product4])
  #   end
  # end

  # describe ".recent" do
  #   before(:each) do
  #     @product1 = FactoryGirl.create :product
  #     @product2 = FactoryGirl.create :product
  #     @product3 = FactoryGirl.create :product
  #     @product4 = FactoryGirl.create :product

  #     @product2.touch
  #     @product3.touch
  #   end

  #   it "returns the most updated records" do
  #     expect(Product.recent).to match_array([@product3, @product2, @product4, @product1])
  #   end
  # end

  # describe ".search" do
  #   before(:each) do
  #     @product1 = FactoryGirl.create :product, price: 100, title: "Plasma tv"
  #     @product2 = FactoryGirl.create :product, price: 50, title: "Videogame console"
  #     @product3 = FactoryGirl.create :product, price: 150, title: "MP3"
  #     @product4 = FactoryGirl.create :product, price: 99, title: "Laptop"
  #   end

  #   context "when title 'videogame' and '100' as min price are set" do
  #     it "returns an empty array" do
  #       search_hash = { keyword: 'videogame', min_price: 100 }
  #       expect(Product.search(search_hash)).to be_empty
  #     end
  #   end

  #   context "when title 'tv', '150' as max price, and '50' as min price are set" do
  #     it "returns returns the product1" do
  #       search_hash = { keyword: 'tv', max_price: 150, min_price: 50 }
  #       expect(Product.search(search_hash)).to match_array([@product1])
  #     end
  #   end

  #   context "when an empty hash is sent" do
  #     it "returns all the products" do
  #       expect(Product.search({})).to match_array([@product1, @product2, @product3, @product4])
  #     end
  #   end

  #   context "when product_ids is present" do
  #     it "returns the product from the ids" do
  #       search_hash = { product_ids: [@product1.id, @product2.id]}
  #       expect(Product.search(search_hash)).to match_array([@product1, @product2])
  #     end
  #   end
  # end

  ############### my version with FactoryGirl instances created once ###########
  describe "searching methods" do

    before(:each) do
      # for methods to filter by title and price
      @product1 = FactoryGirl.create :product, title: "A plasma TV", price: 100
      @product2 = FactoryGirl.create :product, title: "Fastest laptop", price: 50
      @product3 = FactoryGirl.create :product, title: "CD player", price: 150
      @product4 = FactoryGirl.create :product, title: "LCD TV", price: 99

      #for method .recent
      @product2.touch
      @product3.touch
    end

    context ".filter_by_title" do
      context "when a 'TV' title pattern is sent" do
        it "returns the 2 products matching" do
          expect(Product.filter_by_title("TV")).to have(2).items
        end

        it "returns the products matching" do
          expect(Product.filter_by_title("TV").sort).to match_array([@product1, @product4])
        end
      end
    end

    context ".above_or_equal_to_price" do
      it "returns the products which are qbove or equal to the price" do
        expect(Product.above_or_equal_to_price(100).sort).to match_array([@product1, @product3])
      end
    end

    context ".below_or_equal_to_price" do
      it "returns the products which are below or equal to price" do
        expect(Product.below_or_equal_to_price(99).sort).to match_array([@product2, @product4])
      end
    end

    context ".recent" do
      it "returns the most updated records" do
        expect(Product.recent).to match_array([@product3, @product2, @product4, @product1])
      end
    end

    context ".search" do
      context "when title 'laptop' and '100' a min price are set" do
        it "returns an empty array" do
          search_hash = { keyword: 'videogame', min_price: 100 }
          expect(Product.search(search_hash)).to be_empty
        end
      end

      context "when title 'plasma', '150' as max price, and '50' as min price are set" do
        it "returns the product1" do
          search_hash = { keyword: 'plasma', max_price: 150, min_price: 50 }
          expect(Product.search(search_hash)).to match_array([@product1])
        end
      end

      context "when an empty hash is sent" do
        it "returns all the products" do
          expect(Product.search({})).to match_array([@product1, @product2, @product3, @product4])
        end
      end

      context "when product_ids is present" do
        it "returns the product from the ids" do
          search_hash = { product_ids: [@product1.id, @product2.id]}
          expect(Product.search(search_hash)).to match_array([@product1, @product2])
        end
      end
    end
  end
end
