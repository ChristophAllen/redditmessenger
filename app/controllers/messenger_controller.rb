class MessengerController < ApplicationController

	def index
	end

	def save
		require "selenium-webdriver"
		driver = Selenium::WebDriver.for :safari
		driver.navigate.to linktoscrape()
		sleep 3
		50.times do
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
		sleep 3
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
					job().create(name: x.text, job: jobintext(), messagesent: false)
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
	def longpagesave
		require "selenium-webdriver"
		driver = Selenium::WebDriver.for :safari
		driver.navigate.to linktoscrape()
		sleep 3
		50.times do
			driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
			sleep 3
		end
		# links = driver.find_elements(:tag_name, "span")
		# comments_arr = []
		# links.each do |x|
		# 	if ((x.text.split("") & ["c","o","m","m","e","n","t","s"]).length > 6) && (x.text.split("").length < 15)
		# 		comments_arr.push(x)
		# 	end
		# end
		# driver.execute_script("window.scrollTo(0, 0)")
		# sleep 3
		# commcount = 0
		# comments_arr.each do |s|
		# 	sleep 4
		# 	commcount = commcount + 1
		# 	puts commcount
		# 	s.click
		# 	sleep 4
			usernames = driver.find_elements(:tag_name, "a")
			sleep 3
			usernames.each do |x|
				if x.attribute("href").split("/").include?("user") && x.text.split("")[1] == "/"
					tempxvar = x.text.split("").drop(2).join("")
					job().create(name: tempxvar, job: jobintext(), messagesent: false)
				end
			end
			# delete_repeats()
			driver.navigate.back
	end

	def show
		@jobnameforviewpage = jobintext()
		delete_repeats()
		@a = job().all
		@x = [@a]
	end


	def delete_repeats
        options = {
            1 => [job()],
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
		require "selenium-webdriver"
		driver = Selenium::WebDriver.for :safari
		driver.navigate.to "https://www.reddit.com/login/"
		sleep 3
		user = driver.find_element(name: 'username')
		user.send_keys "negativedisplay"
		pass = driver.find_element(name: 'password')
		pass.send_keys "Guppy303*"
		pass.submit
		sleep 10
		driver.navigate.to "https://www.reddit.com/message/compose/"
		sleep 10
		frame = driver.find_elements(:tag_name, "iframe")
		sleep 10
		driver.switch_to.frame(0)
		sleep 10
		to = driver.find_element(name: 'to')
		subject = driver.find_element(name: 'subject')
		text = driver.find_elements(name: 'text')
		submit = driver.find_element(name: 'send')
		# job().all.each do |x|      
		# 	if x.messagesent == true || x.name.split(" ").include?("comments")
		# 		puts "option 1 happened"
		# 	elsif to.attribute('value').length > 0 || subject.attribute('value').length > 0
		# 		puts "option 2 happened"
		# 		driver.navigate.to "https://www.reddit.com/message/compose/"
		# 		sleep 10
		# 		frame = driver.find_elements(:tag_name, "iframe")
		# 		sleep 10
		# 		driver.switch_to.frame(0)
		# 		sleep 10
		# 		to = driver.find_element(name: 'to')
		# 		subject = driver.find_element(name: 'subject')
		# 		text = driver.find_elements(name: 'text')
		# 		submit = driver.find_element(name: 'send')
		# 		sleep 5
		# 	else
				# puts "option 3 happened"
				# to.send_keys x.name
				# sleep 2
				# subject.send_keys subjecttemplate()
				# sleep 3
				# text[1].send_keys texttemplate()
				# sleep 9
				# x.update_column(:messagesent, true)
				# submit.click
				# sleep 3
			# end
		# end
	end




	def subjecttemplate
		# return "I'm interested in the nursing profession"
		return "Army Profession"
	end

	def texttemplate
		return "Hey, sorry if this is a bother but I found your username through the Accounting subreddit.  I’m an amateur web developer who is trying to build a resource to help young people decide what they want to do in life.  Just want to make something cool while I’m saving up to go back to school.  The idea I’ve built is a video upload platform where young people can go to watch others talk about what a day is like in their life in regards to there job.  To maybe help them decide what they want to do in life.  Calling it DayInTheLifeOf.  And I’m on the part where I’m trying to get videos.  Would you be interested in taking a few minute video of yourself talking about what it’s like to be an accountant(**don’t have to show your face**)?  And I bought some meager gold to give out for anyone interested.  The site is going to be free to use, and ad free if that matters to you.  If you are interested I have a short list of questions I could send to give an idea of things to talk about, and a dropbox link to upload the video to.  If not, no worries and my apologies for bothering."
	end

	def job
		return Vet
	end

	def jobintext
		return "Vet"
	end

	def linktoscrape
		return "https://www.reddit.com/r/veterinarian/"
	end

end



# sent messages for Nurses and Engineers (could scrape more for the Engineers simply b/c I need more videos from them)


# 2.1k Nurses collected and sent
# 300 Engineers collect and sent
# 2.2k Lawyers collected 
# 2k Teachers collected and sent
# 1.3k Officers collected
# 1.1k Accountants collected
# 280 Army collected
# 450 Navy collected
# 769 Firefighters collected




# thelittleestbadwolf, bignbootylicious, theoneandonlygod, 

