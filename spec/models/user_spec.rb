# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should allow_value('test@mail.com').for(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password) }
end
