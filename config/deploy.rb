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

default_run_options[:pty] = true

role :web, "cfp.wrocloverb.com"
role :app, "cfp.wrocloverb.com"
role :db,  "cfp.wrocloverb.com", :primary => true

namespace :deploy do
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
