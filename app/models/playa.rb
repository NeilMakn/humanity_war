class Playa < ActiveRecord::Base
  attr_accessible :email
  has_many :entries

  validates_presence_of :email, on: :create, message: "can't be blank"
  validates_format_of :email, :with => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/

  def to_s
   self.email
  end
end
