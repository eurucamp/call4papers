require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, "cfp"
set :user, "#{application}"
set :sevice, "#{application}"
set :deploy_to, "/srv/#{application}"
set :deploy_via, :remote_cache
set :repository, "git@github.com:drugpl/call4papers.git"
set :scm, :git
set :ssh_options, {:forward_agent => true}
set :keep_releases, 5
set :bundle_without, %w(test development)
set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user
set :use_sudo, false

default_run_options[:pty] = true

role :web, "wrocloverb-cfp"
role :app, "wrocloverb-cfp"
role :db,  "wrocloverb-cfp", :primary => true

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    # run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"

  end

  task :start, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} sv start /etc/service/#{fetch(:service)}"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} sv stop /etc/service/#{fetch(:service)}"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} sv restart /etc/service/#{fetch(:service)}"
  end

  task :status, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} sv status /etc/service/#{fetch(:service)}"
  end
end

namespace :deploy do
  desc "Create configuration symlinks."
  task :create_symlinks do
    ['database.yml', 'unicorn.rb'].each do |config|
      run "cd #{release_path} && ln -snf #{shared_path}/#{config} #{release_path}/config/#{config}"
    end
  end
end

after 'deploy:update_code', 'deploy:create_symlinks'
