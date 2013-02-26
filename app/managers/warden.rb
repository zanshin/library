use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = FailureApp.new
end
###
 
### Session Setup
# Tell Warden how to serialize the user in and out of the session.
#
Warden::Manager.serialize_into_session do |user|
  puts '[INFO] serialize into session'
  user.id
end
 
Warden::Manager.serialize_from_session do |id|
  puts '[INFO] serialize from session'
  User.get(id)
end
###
 
### Declare Some Strategies
#
Warden::Strategies.add(:password) do
  def valid?
    puts '[INFO] password strategy valid?'
    
    params['username'] || params['password']
  end
  
  def authenticate!
    puts '[INFO] password strategy authenticate'
 
    u = User.authenticate(params['username'], params['password'])
    u.nil? ? fail!('Could not login in') : success!(u)
  end
end
###
 
class FailureApp
  def call(env)
    uri = env['REQUEST_URI']
    puts "failure #{env['REQUEST_METHOD']} #{uri}"
  end
end
