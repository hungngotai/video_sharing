require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:src) }
    it { should allow_value("https://youtu.be/uCHuTxVYtsk").for(:src) }
  end
end
