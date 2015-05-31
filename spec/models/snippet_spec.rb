require 'rails_helper'

RSpec.describe Snippet, type: :model do

  describe 'validation' do
    it { should have_db_column(:name).of_type(:string) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }

    it { should have_db_column(:content).of_type(:text) }
    it { should validate_presence_of(:content) }

    it { should have_db_column(:execution_output).of_type(:text) }
    
    it { should belong_to(:user) }
    it { should validate_presence_of(:user_id).with_message('User does not exist!') }
  end

end
