urls = [
  "https://youtu.be/uCHuTxVYtsk",
  "https://youtu.be/fhdX3Wcxwas",
  "https://youtu.be/YxnkTTVHCtg"
]

urls.each { |url| Video.new(src: url).save! }
p "001 > Videos created!"
