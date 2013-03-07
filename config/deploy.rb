require 'bundler/capistrano'

set :application, "cfp"
set :user, "#{application}"
set :service, "#{application}"
set :deploy_to, "/srv/#{application}"
set :deploy_via, :remote_cache
set :repository, "git@github.com:drugpl/call4papers.git"
set :scm, :git
set :ssh_options, {:forward_agent => true}
set :keep_releases, 5
set :bundle_without, %w(test development)
set :use_sudo, false
set :unicorn_binary, "unicorn"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid,    "#{current_path}/tmp/pids/unicorn.pid"

default_run_options[:pty] = true

role :web, "cfp.eurucamp.org"
role :app, "cfp.eurucamp.org"
role :db,  "cfp.eurucamp.org", :primary => true

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{try_sudo} bundle exec #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end

  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end

  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end

  desc "Create configuration symlinks."
  task :create_symlinks do
    %w(database.yml unicorn.rb).each do |config|
      run "cd #{release_path} && ln -snf #{shared_path}/#{config} #{release_path}/config/#{config}"
    end
    run "ln -nfs #{shared_path}/log #{release_path}/log"
    run "ln -nfs #{shared_path}/tmp #{release_path}/tmp"
    run "rm #{release_path}/config/environments/production.rb && ln -nfs #{shared_path}/production.rb #{release_path}/config/environments/production.rb"
  end

  task :pipeline_precompile do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile"
  end

  task :link_secret_token do
    run "if [ -f #{deploy_to}/shared/secret_token.rb ] ; then ln -sf #{deploy_to}/shared/secret_token.rb #{latest_release}/config/initializers/; fi"
  end
end

after 'deploy:update_code', 'deploy:create_symlinks'
after "deploy:update_code", "deploy:pipeline_precompile"
after "deploy:update_code", "deploy:link_secret_token"
