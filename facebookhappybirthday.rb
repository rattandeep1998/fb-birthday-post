require 'watir'
require 'highline/import'

browser = Watir::Browser.new :chrome
browser.goto 'https://www.facebook.com'

puts "HAPPY BIRTHDAY WISHES ON FACEBOOK"
puts "This portal post birthday wishes on your friend's wall."
print "Enter Email : "
email = gets.chomp

cli = HighLine.new
password = cli.ask("Enter Your Password: ") { |q| q.echo = false }

browser.text_field(:type => 'email').set email
browser.text_field(:type => 'password').set password
browser.div(:class => 'menu_login_container rfloat _ohf').form(:id => 'login_form').submit
sleep 5

#birthdayPost1 = "Special day, special person and special celebration. May all your dreams and desires come true in this coming year. Happy Birthday. 🎂🎂"
birthdayPost1 = "I hope all of your hopes and dreams come true on this very special day. Happy birthday to you! 🎂"
birthdayPost2 = "I wish you a wonderful, joyful and fun-filled happy birthday. 🎂🎂🎉🎉🎉❤ :D"
birthdayPost3 = "Wishing you a very happy birthday and many more to come. Hope it’s a good one. 🎂❤"
birthdayPost4 = "Happy Birthday !! 🎂🎂"

browser.goto 'https://www.facebook.com/events/birthdays'

birthdayList = browser.div(:id => 'events_birthday_view').div(:class => '_4-u2 _59ha _2fv9 _4-u8').ul(:class => '_3ng0')

birthdayList.lis.each do |li|
	personName = li.div(:class => 'clearfix _3ng1').div(:class => '_42ef').div(:class => '_3ng2 lfloat _ohe').a.text
	checkVisibleAge = li.div(:class => '_1vtl rfloat _ohf fsm fwn fcg').present?
	age = 0
	if checkVisibleAge
		age = li.div(:class => '_1vtl rfloat _ohf fsm fwn fcg').text.split.first.to_i
		puts "#{personName} is #{age} years old."
	end

	#Birthday Posts According To Age
	if age > 10 && age < 20
		birthdayPost=birthdayPost1;
	elsif age >= 20 && age < 30
		birthdayPost=birthdayPost2;
	elsif age>=30 && age<40
		birthdayPost=birthdayPost3;
	else
		birthdayPost=birthdayPost4;
	end

	if li.textarea.present?
		li.textarea.set "#{birthdayPost}"
		sleep 5
		browser.send_keys :enter
		puts 'You wished "#{birthdayPost}" to "#{personName}" .'
	end

	#puts 'You wished "#{birthdayPost}" to "#{personName}" .'
	sleep 10
end

puts ""
puts "Your birthday wish made their day a little bit more special.Thanks :)"
