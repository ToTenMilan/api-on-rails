class Placement < ApplicationRecord
  belongs_to :order, inverse_of: :placements # inverse_of option will add little boost when referenecing the parent object
  belongs_to :product, inverse_of: :placements # inverse_of option will add little boost when referenecing the parent object
end
