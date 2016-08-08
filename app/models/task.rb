class Task < ApplicationRecord
  belongs_to :list

  validates_presence_of :name, :done, :list_id
end
