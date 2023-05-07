# frozen_string_literal: true

User.new(email: 'test@email.com', password: '12345678').save!
Rails.logger.debug '002 > Users created!'
