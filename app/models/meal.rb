class Meal < ApplicationRecord
  enum :food, [ :breast, :bank, :formula ]
end
