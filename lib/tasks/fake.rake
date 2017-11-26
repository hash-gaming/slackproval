namespace :fake do
  desc "Create fake requests"
  task requests: :environment do
    100.times do |i|
      email = Faker::Internet.email
      puts "[#{i}] Generating request for #{email}"
      Request.create(email: email, reason: Faker::Hacker.say_something_smart, ip: Faker::Internet.ip_v4_address, code_of_conduct: true)
    end
  end
end
