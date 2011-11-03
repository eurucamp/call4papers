require 'bundler/capistrano'
require 'rvm/capistrano'

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
set :rvm_ruby_string, '1.9.2'
set :use_sudo, false

default_run_options[:pty] = true

role :web, "wrocloverb-cfp"
role :app, "wrocloverb-cfp"
role :db,  "wrocloverb-cfp", :primary => true

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "sudo sv start /etc/service/#{fetch(:service)}"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "sudo sv stop /etc/service/#{fetch(:service)}"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "sudo sv restart /etc/service/#{fetch(:service)}"
  end

  task :status, :roles => :app, :except => { :no_release => true } do
    run "sudo sv status /etc/service/#{fetch(:service)}"
  end
end

namespace :deploy do
  desc "Create configuration symlinks."
  task :create_symlinks do
    %w(database.yml unicorn.rb user.cnf pass.cnf).each do |config|
      run "cd #{release_path} && ln -snf #{shared_path}/#{config} #{release_path}/config/#{config}"
    end
    run "ln -nfs #{shared_path}/log #{release_path}/log"
    run "ln -nfs #{shared_path}/tmp #{release_path}/tmp"
  end

  task :pipeline_precompile do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile"
  end
end

after 'deploy:update_code', 'deploy:create_symlinks'
after "deploy:update_code", "deploy:pipeline_precompile"
