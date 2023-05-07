# frozen_string_literal: true

urls = [
  'https://www.youtube.com/embed/uCHuTxVYtsk',
  'https://www.youtube.com/embed/fhdX3Wcxwas',
  'https://www.youtube.com/embed/YxnkTTVHCtg'
]

urls.each { |url| Video.new(src: url).save! }
p '001 > Videos created!'
