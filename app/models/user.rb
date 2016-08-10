class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :lists
  has_many :favorite_lists, -> { joins(:list).select('lists.id AS list_id, lists.name AS list_name') }
  
  validates_presence_of :name, :encrypted_password, :email

  def get_showable_lists
    lists.where("(public = ? or user_id = ?) and done = ?", true, self.id, false)
  end

  def favorited?(list)
    favorite_lists.map(&:list_id).include?(list.id)
  end

  def add_favorite_list(list)
    unless favorited? list
      favorite_lists << FavoriteList.new(list_id: list.id)
    end
  end

  def remove_favorite_list(list)
    FavoriteList.find_by(user_id: id, list_id: list.id).destroy
  end
end
