# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:src) }
    it { is_expected.to allow_value('https://youtu.be/uCHuTxVYtsk').for(:src) }
  end
end
