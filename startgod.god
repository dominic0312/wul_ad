ADMIN_ROOT = '/home/wooul/admin.wooul.com/current'
ADMIN_PID_DIR = '/home/wooul/admin.wooul.com/current/tmp/pids'
RAILS_ENV = 'production'
WEB_ROOT = '/home/www/wul'
WEB_PID_DIR = '/home/www/wul/tmp/pids'
BIN_PATH   = "/usr/local/rvm/rubies/ruby-2.1.1/bin"
UID = 'wooul'
#GID = 'root'

God.log_file  = "#{ADMIN_ROOT}/log/god.log"
God.log_level = :info

%w(unicorn_ad sidekiq_ad).each do |config|
  God.load "#{ADMIN_ROOT}/config/#{config}.god"
end

#%w(unicorn_web sidekiq_web).each do |config|
#  God.load "#{ADMIN_ROOT}/config/#{config}.god"
#end

