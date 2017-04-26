APP_ROOT = File.expand_path(File.dirname(File.dirname(__FILE__)))

$LOAD_PATH.unshift File.join(APP_ROOT, 'lib')

require 'parliament'

port              = Integer(ENV['PORT'] || 5000)
unix_socket       = ENV['SOCKET'] || '/tmp/parliament.sock'

no_of_processes   = Integer(ENV['PROCESSES'] || 1)
min_no_of_threads = Integer(ENV['MIN_THREADS'] || 8)
max_no_of_threads = Integer(ENV['MAX_THREADS'] || 32)

tag               'parliament'
environment       ENV['RACK_ENV'] || 'production'
daemonize         false
worker_timeout    15

pidfile           ENV['PID_FILE'] if ENV['PID_FILE']
state_path        ENV['STATE_FILE'] if ENV['STATE_FILE']

threads           min_no_of_threads, max_no_of_threads
workers           no_of_processes

bind              "tcp://0.0.0.0:#{port}"
bind              "unix://#{unix_socket}"

preload_app!
