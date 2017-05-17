require 'sinatra'
require 'json'
require 'pp'
require 'active_support/core_ext/hash'
#require 'rake'

post '/payload' do
  push = JSON.parse(request.body.read)
  json=push.with_indifferent_access
  #json=push.inspect
  #puts "I got some JSON: #{push.inspect}"
  puts "I got some JSON: #{json["comment"]}"
  body = json["comment"]["body"]
  action = json["action"]
  
  pp "#{action} : #{body}"
 
  
  #save the content of Issue_Comment=>comment=>body  to "output.json"
  f = File.new(File.join("output.json"),"w+")
  f.puts(json)
  f.close
  
  if (action=="created")&&((body.include? "restart build") || (body.include? "retest") || (body.include? "rebuild"))
      puts "restart build it"  
	  system('travis login --github "48eb908cb8ac911d675524cf0a57a3ba5b58157c"')
	  system('cd C:/Xcat')
	  system('travis restart -r DengShuaiSimon/Xcat')
	  #system('travis restart')
	  #system("./travis.sh")
	  #_shellScript = "./travis.sh"
      #exec 'sh #{_shellScript}'
  else
      puts "no match or delete it"
end
  
end
