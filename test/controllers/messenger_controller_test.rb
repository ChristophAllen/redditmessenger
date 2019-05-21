require 'test_helper'
require 'selenium-webdriver'
require 'watir'
require 'webdrivers'

class MessengerControllerTest < ActionDispatch::IntegrationTest
	def setup
		@driver = Selenium::WebDriver.for :safari
		@driver.navigate.to "https://www.reddit.com/login/"
	end

  	test "navigated successfully to login page" do
    	assert_equal 'reddit.com: Log in', @driver.title
  	end

  	test "found login element successfully" do
  		user = @driver.find_element(name: 'username')
  		assert_not_nil user, "found username element"
  	end

  	test "entered login successfully" do
  		user = @driver.find_element(name: 'username')
  		user.send_keys 'negativedisplay'
  		assert_equal "negativedisplay", user.attribute("value"), "username text entered successfully"
  	end  	

  	test "found password element successfully" do
  		password = @driver.find_element(name: 'password')
  		assert_not_nil password
  	end

  	test "entered password successfully" do
  		password = @driver.find_element(name: 'password')
  		password.send_keys 'Guppy303*'
  		assert_equal "Guppy303*", password.attribute("value"), "password text entered successfully"
  	end  

  	test "logged in successfully" do
  	  	user = @driver.find_element(name: 'username')
  		user.send_keys "negativedisplay"
  		password = @driver.find_element(name: 'password')
  		password.send_keys "Guppy303*"
  		password.submit
  		sleep 10
    	assert_equal 'reddit: the front page of the internet', @driver.title
  	end  

  	test 'finding sendmessage text boxes and sending a message' do
  		user = @driver.find_element(name: 'username')
  		user.send_keys "negativedisplay"
  		password = @driver.find_element(name: 'password')
  		password.send_keys "Guppy303*"
  		password.submit
  		sleep 5
  		@driver.navigate.to "https://www.reddit.com/message/compose/"
  		sleep 2
  		frame = @driver.find_elements(:tag_name, "iframe")
		sleep 10
		@driver.switch_to.frame(0)
		sleep 10
		to = @driver.find_element(name: 'to')
		subject = @driver.find_element(name: 'subject')
		text = @driver.find_elements(name: 'text')
		submit = @driver.find_element(name: 'send')
		to.send_keys 'hoopla'
		subject.send_keys 'other hoopla'
		text[1].send_keys 'third hoopla'
  	end  	


  	def teardown
  		@driver.quit
  	end
end

	# 			puts "option 3 happened"
	# 			to.send_keys x.name
	# 			sleep 2
	# 			subject.send_keys subjecttemplate()
	# 			sleep 3
	# 			text[1].send_keys texttemplate()
	# 			sleep 9
	# 			x.update_column(:messagesent, true)
	# 			submit.click
	# 			sleep 3
	# 		end
	# 	end
	# end