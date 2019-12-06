set :application, "rafaelbiriba-about-me"

set :repository,  "./_site_production"

role :web, ENV.fetch("rafaelbiribacom_server_deploy")

set :deploy_via, :copy

set :scm, "none"

set :user, ENV.fetch("rafaelbiribacom_user_deploy")

set :use_sudo, false

set :deploy_to, "#{ENV.fetch("rafaelbiribacom_deploy_to")}/#{fetch(:application)}"

set :keep_releases, 3

namespace :deploy do
  [:start, :stop, :restart, :finalize_update].each do |t|
    desc "#{t} task is a no-op with jekyll"
    task t do ; end
  end

  desc "Run jekyll to update site before uploading"
  task :update_jekyll do
    %x(rm -rf _site_production/* && bundle exec jekyll build -c config/jekyll_config.yml,config/jekyll_config_production.yml)
  end

  task :delete_revision_file do
    run "cd #{fetch(:deploy_to)}/current/; rm -f REVISION"
  end

end

before "deploy:update", "deploy:update_jekyll"
after "deploy:update", "deploy:cleanup"
after "deploy:cleanup", "deploy:delete_revision_file"
