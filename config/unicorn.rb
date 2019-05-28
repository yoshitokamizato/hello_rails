rails_root = File.expand_path('../../', __FILE__)

worker_processes 2
working_directory rails_root

listen "/var/www/rails/hello_rails/tmp/sockets/unicorn.sock"
pid "/var/www/rails/hello_rails/tmp/pids/unicorn.pid"

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

stderr_path "/var/www/rails/hello_rails/log/unicorn_error.log"
stdout_path "/var/www/rails/hello_rails/log/unicorn.log"
