require 'rails_helper'

RSpec.describe User, type: :model do
 
  describe 'validation' do
    it { should have_db_column(:username).of_type(:string) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    
    it { should have_db_column(:email).of_type(:string) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_length_of(:password).is_at_least(8).is_at_most(72) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:remember_created_at).of_type(:datetime) }

    it { should have_db_column(:sign_in_count).of_type(:integer) }
    it { should have_db_column(:current_sign_in_at).of_type(:datetime) }
    it { should have_db_column(:last_sign_in_at).of_type(:datetime) }
    it { should have_db_column(:current_sign_in_ip).of_type(:inet) }
    it { should have_db_column(:last_sign_in_ip).of_type(:inet) }

    it { should have_many(:snippets) }
  end
  
end
