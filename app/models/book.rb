class Book < ActiveRecord::Base
  has_many :borrowers
end
