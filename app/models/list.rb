class List < ApplicationRecord
  has_many :tasks

  validates_presence_of :name, :user_id

  def created_by?(user)
    user_id == user.id
  end

  def add_mark_public(list)
    mark_public(list, true)
  end

  def remove_mark_public(list)
    mark_public(list, false)
  end

  def mark_public(list, value=true)
    list.update_columns(public: value)
  end
end
