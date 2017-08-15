require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #show" do
    before(:each) do
      @product = FactoryGirl.create :product # create product
      get :show, params: { id: @product.id }  # send get request
    end

    it "returns the information about reporter on a hash" do
      product_response = json_response # parse json response
      expect(product_response[:title]).to eql @product.title #check whether @product.title is in response
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :product }
      get :index
    end

    it "returns 4 records from the database" do
      products_response = json_response
      expect(products_response).to have(4).items
    end

    it { should respond_with 200 }
  end

end
