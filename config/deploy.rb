set :stages, %w[local ri ga ct]
set :default_stage, "local"

require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :application, "dashboard"

set :repository, "git@github.com:tbrooke/momma_dashboard.git"
set :deploy_via, :remote_cache

set :scm, :git
set :user, "deploy"

set :deploy_to, "/var/www/#{application}"
set :use_sudo, false

after 'deploy:update_code' do
  { "msm.yml"         => "config/mom.yml",
    "log"             => "log" }.
   each do |from, to|
     run "ln -nfs #{shared_path}/#{from} #{release_path}/#{to}"
   end
end

 desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end

after "deploy", "deploy:cleanup"

after "deploy" do
  run "sudo restart dashboard"
end
