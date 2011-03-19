set :application, "braintease"
set :repository,  "git@github.com:herval/braintease.git"

role :web, "74.63.3.54"                          # Your HTTP server, Apache/etc
role :app, "74.63.3.54"                          # This may be the same as your `Web` server
role :db,  "74.63.3.54", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


set :default_environment, {
  'PATH' => "/home/deployer/.rvm/rubies/ruby-1.9.2-p180/bin:/home/deployer/.rvm/bin:$PATH",
  'RUBY_VERSION' => 'ruby-1.9.2-p180',
  'GEM_HOME'     => '/home/deployer/.rvm/gems/ruby-1.9.2-p180',
  'GEM_PATH'     => '/home/deployer/.rvm/gems/ruby-1.9.2-p180',
  'BUNDLE_PATH'  => '/home/deployer/.rvm/gems/ruby-1.9.2-p180'
}

set :user, "deployer"
set :rails_env, 'production'
set :deploy_to, "/home/deployer/braintease"

set :use_sudo, false
set :scm, :git
set :scm_verbose, true
set :branch, "master"
set :git_shallow_clone,   1
set :keep_releases,       5

task :symlink_database do
  run "rm -f #{release_path}/config/database.yml"
  run "ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
end
after 'deploy:update_code', 'symlink_database'


# 
# namespace :deploy do
#   task :start do
#     run "/etc/init.d/cms start"
#   end
#   task :stop do
#     run "/etc/init.d/cms stop"
#   end
#   task :restart do
#     run "/etc/init.d/cms reload"
#   end
# end