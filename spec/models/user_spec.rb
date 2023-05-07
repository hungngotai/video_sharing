# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to allow_value('test@mail.com').for(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password) }
end
