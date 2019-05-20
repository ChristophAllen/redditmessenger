class UsernameController < ApplicationController
	def collect2
		# 50.times do
			# collect2()
			# require "selenium-webdriver"
			# driver = Selenium::WebDriver.for :chrome
			driver.navigate.to "https://www.reddit.com/register/"
			email = driver.find_element(id: 'regEmail')
			email.send_keys "thisemaildoestmatter@gmail.com"
			emailnextbutton = driver.find_element(class: 'AnimatedForm__nextButton')
			emailnextbutton.click
			sleep 5
			username = driver.find_element(id: 'regUsername')
			randomizedusername = (0...20).map { ('a'..'z').to_a[rand(26)] }.join
			username.send_keys randomizedusername
			password = driver.find_element(id: 'regUsername')
			randomizedpassword = (0...20).map { ('a'..'z').to_a[rand(26)] }.join
			password.send_keys randomizedpassword
			frame = driver.find_elements(:tag_name, "iframe")
			driver.switch_to.frame(0)
			captchabox = driver.find_element(class: 'recaptcha-checkbox-checkmark')
			captchabox.click
			sleep 5
			Username.create(username: randomizedusername, password: randomizedpassword)
			while driver.find_element(id: 'regEmail')
				sleep 2
				puts 'on pause while captcha is still up'
			end
		# end
	end


	def upvote
		@usernames = Username.all
		# require 'selenium-webdriver'

		# what = '127.0.0.1:9150'

		# profile = Selenium::WebDriver::Firefox::Profile.new
		# profile.proxy = Selenium::WebDriver::Proxy.new(
		#   :http     => what,
		#   :ftp      => what,
		#   :ssl      => what,
		# )

		# driver = Selenium::WebDriver.for :firefox, :profile => profile
		# driver.navigate.to "https://www.whatismyip.com/what-is-my-public-ip-address/"
	end


	def collect
		require 'selenium-webdriver'
		#################################################
		driver = Selenium::WebDriver.for :chrome
		driver.navigate.to "https://www.reddit.com/register/"
		sleeper()
		email = driver.find_element(id: 'regEmail')
		email = (0...9).map { ('a'..'z').to_a[rand(26)] }.join + "@gmail.com"
		email.send_keys email
		sleeper()
		emailnextbutton = driver.find_element(class: 'AnimatedForm__nextButton')
		emailnextbutton.click
		sleeper()
		username = driver.find_element(id: 'regUsername')
		randomizedusername = (0...19).map { ('a'..'z').to_a[rand(26)] }.join
		sleeper()
		username.send_keys randomizedusername
		password = driver.find_element(id: 'regPassword')
		randomizedpassword = (0...19).map { ('a'..'z').to_a[rand(26)] }.join
		sleeper()
		password.send_keys randomizedpassword
		# frame = driver.find_elements(:tag_name, "iframe")
		# driver.switch_to.frame(0)
		sleep 5
		# captchabox = driver.find_element(class: 'recaptcha-checkbox-checkmark')
		# captchabox.click
		Username.create(username: randomizedusername, password: randomizedpassword)
	end

	def sleeper
		sleep 3
	end
end