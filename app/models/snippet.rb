class Snippet < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: true, uniqueness: {:case_sensitive => false}
  validates_presence_of :content
  validate :user_id_exists

protected
  def user_id_exists
    if !User.where(id: self.user_id).exists? then
      errors.add(:user_id, 'User does not exist!')
      false
    end
  end
end
