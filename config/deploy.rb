require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)

set :rails_env, 'production'
set :application_name, 'my_blog'
set :domain, '161.35.91.4'
set :deploy_to, '/home/deploy/my_blog'
set :repository,  'git@github.com:dimonrud911/my_blog.git'
set :branch, 'master' #"feature/production"

# Optional settings:
set :user, 'deploy'          # Username in the server to SSH to.
# set :port, '3000'          # SSH port number.
set :forward_agent, true     # SSH forward_agent.

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
# set :shared_dirs, fetch(:shared_dirs, []).push('public/assets')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', '.env')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  invoke :'rbenv:load'
  # invoke :'rvm:use', 'ruby-1.9.3-p125@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %[touch "#{fetch(:deploy_to)}/shared/config/database.yml"]
  # command %[touch "#{fetch(:deploy_to)}/shared/config/secrets.yml"]
  # command %{rbenv install 2.3.0 --skip-existing}
end

desc "Deploys the current version to the server."
task :deploy do
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # invoke :'rails:db_create'
    invoke :'rails:db_migrate'
    # invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
    end
  end
end

task :restart do
  comment %{Restart application}
  command %{sudo service nginx restart}
end

desc 'Create database'
task :'rails[db:create]' do
  comment %{Creating database}
  command %{#{fetch(:rake)} db:create}
end

desc 'Run migrations'
task :'rails[db:migrate]' do
  comment %{Runing migrations}
  command %{#{fetch(:rake)} db:migrate}
end

desc 'Create seeds'
task :'rails[db:seed]' do
  comment %{Creating seeds}
  command %{#{fetch(:rake)} db:seed}
end

desc 'Rollback database'
task :'rails[db:rollback]' do
  comment %{Rollbacking database}
  command %{#{fetch(:rake)} db:rollback}
end
# you can use `run :local` to run tasks on local machine before of after the deploy scripts
# run(:local){ say 'done' }
