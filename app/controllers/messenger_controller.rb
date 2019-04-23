class MessengerController < ApplicationController

	def index
	end

	def save
		require "selenium-webdriver"
		driver = Selenium::WebDriver.for :safari
		driver.navigate.to "https://www.reddit.com/r/nursing/"
		20.times do
			driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
			sleep 2
		end
		links = driver.find_elements(:tag_name, "span")
		comments_arr = []
		links.each do |x|
			if ((x.text.split("") & ["c","o","m","m","e","n","t","s"]).length > 6) && (x.text.split("").length < 15)
				comments_arr.push(x)
			end
		end
		driver.execute_script("window.scrollTo(0, 0)")
		commcount = 0
		comments_arr.each do |s|
			sleep 4
			commcount = commcount + 1
			puts commcount
			s.click
			sleep 4
			usernames = driver.find_elements(:tag_name, "a")
			sleep 3
			usernames.each do |x|
				if x.attribute("href").split("/").include?("user") && !x.text.split("").include?("/")
					Nurse.create(name: x.text, job: 'nurse')
				end
			end
			# delete_repeats()
			driver.navigate.back
		end
	end
# t.string  "name"
# t.boolean  "messagesent"
# t.string  "job"
# 1 = 7
# 10 = 35
# 50 = 143
# 100 = 364
# 150 = 776: 12 more posts from this hits the limit 
	def delete
		# @objs = Nurse.all
		# Nurse.delete_all
	end

	def show
		delete_repeats()
		@a = Nurse.all
		@x = [@a]
	end


	def delete_repeats
        options = {
            1 => [Nurse],
        }
        options.each do |key,value|
            value[0].all.each do |x|
            z = 0                
                value[0].all.each do |y|
                    if y.name == x.name
                        z = z + 1
                        
                        if z > 1 
                            y.destroy
                        end
                    end
                end   
                
            end 
        end
	end




	def sendmessage
		# driver.navigate.to "https://www.reddit.com/login/"
		# user = driver.find_element(name: 'username')
		# user.send_keys "negativedisplay"
		# pass = driver.find_element(name: 'password')
		# pass.send_keys "Guppy303*"
		# pass.submit
		# sleep 5
	end
end
