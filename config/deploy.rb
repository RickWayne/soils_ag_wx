set :application, 'soils_ag_wx'
set :repo_url, 'https://github.com/RickWayne/soils_ag_wx.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end

# from https://gist.github.com/reu/665385
# this first line must be a Cap 2 thing
# before "deploy:setup", "db:configure"
# before  "deploy:restart", "db:yaml_symlink"
 
# namespace :db do
#  
#   desc "Make symlink for database yaml"
#   task :yaml_symlink do
#     run "ln -nfs #{deploy_to}/shared/config/database.yml #{deploy_to}/current/config/database.yml"
#   end
# end

