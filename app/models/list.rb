class List < ApplicationRecord
  validates_presence_of :name, :public, :user_id
end
