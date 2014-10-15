
worker_processes 4


APP_PATH = "/home/mycloud/wul_back"

working_directory APP_PATH 

listen "/home/mycloud/god/sockets/wul_back.sock", :backlog => 64


# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# feel free to point this anywhere accessible on the filesystem
pid "/home/mycloud/god/pids/wul_back.pid"

stderr_path "/home/mycloud/god/logs/wul_back_err.log"
stdout_path "/home/mycloud/god/logs/wul_back_std.log"


# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true


before_exec do |server|
   ENV['BUNDLE_GEMFILE'] = APP_PATH + "/Gemfile"
end

check_client_connection false

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
    
    
old_pid = "#{server.config[:pid]}.oldbin"
   if old_pid != server.pid
      begin
         sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
         Process.kill(sig, File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
   end
  # sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
