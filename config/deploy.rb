load 'deploy' if respond_to?(:namespace) # cap2 differentiator

set :application, "simple_support" 
set :env, (ENV['DEPLOY'] || "staging")

if env == 'production'
   puts "*** Deploying to Production"
   set :vhost_root, "/var/www/simple_support"
else
   puts "*** Deploying to Staging"
   set :vhost_root, "/var/www/simple_support_staging"
end

set :repository,  "git@github.com:loop-recur/Simple-Support.git"
set :scm, "git"
set :branch, (ENV["BRANCH"] || "master")
set :scm_passphrase, "dragonslayer21" #This is your custom users password
set :user, "looprecur"
set :group, "looprecur"
set :deploy_to, "#{vhost_root}/looprecur"
set :http_root, "#{vhost_root}/public"
set :use_sudo, false
set :port, 2525
set :domain, "looprecur-slice"
set :site_name, "simple_support"

set :db_user, "root"
set :db_pass, "e5FtM4pxB7w"

role :web, domain
role :staging, domain


namespace :deploy do
  set :app_command, "/etc/init.d/apache2"
    
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :staging do ; end
  end
  
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :staging, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :bundler do
  task :create_symlink, :roles => :staging do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end

  task :bundle_new_release, :roles => :staging do
    bundler.create_symlink
    run "cd #{release_path} ; #{try_sudo} bundle install --without test"
  end
end

namespace :files do
  task :symlink, :roles => :staging do
    run "ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/domains.yml #{release_path}/config/domains.yml"
    run "ln -s #{shared_path}/files #{release_path}/public/files"
    # run "ln -s /usr/local/WowzaMediaServer/content/ #{release_path}/public/files"
  end
end

namespace :db do
  task :migrate do
    run "cd #{release_path} && rake db:migrate RAILS_ENV=#{env}"
  end
end

after 'deploy:update_code', 'files:symlink'

        require './config/boot'
        # require 'hoptoad_notifier/capistrano'
