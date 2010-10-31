set :application, "crunchhunch"

set :user, "deployer"
set :domain, "184.106.227.114"
set :deploy_to, "/var/www/#{application}"
set :use_sudo, true

set :scm, :git
set :repository,  "git@github.com:andrewpbrett/Crunchhunch.git"
set :branch, 'master'

role :web, domain                         
role :app, domain                         
role :db,  domain, :primary => true

ssh_options[:forward_agent] = true

default_run_options[:pty] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  desc "Change owner"
  task :chown, :roles => :app do
    run "chown deployer:apps -R #{latest_release}"
  end
  desc "Restart appliction"  
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end 
  desc "Copy database.yml"
  task :dbconfig do
    run "cp #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end
end

after "deploy:update_code", "deploy:chown"
after "deploy", "deploy:dbconfig"

namespace :db do
  namespace :sync do
    desc "copy local db up to production"
    task :up do
      db = YAML.load_file("config/database.yml")      
      # TODO this spits out the pwd in the terminal. be careful of people standing
      # over your shoulder
      prod = db["production"]["password"]
      system "mysqldump -u root -p hunchcrunch_development > ~/hunchcrunch.sql"
      system "scp ~/andy30.sql #{user}@#{domain}:~/"
      run "mysql -u root -p#{prod} hunchcrunch_production < ~/hunchcrunch.sql"
    end
    desc "copy production db down to local"
    task :down do
      db = YAML.load_file("config/database.yml")      
      prod = db["production"]["password"]      
      run "mysqldump -u root -p#{prod} hunchcrunch_production > ~/hunchcrunch.sql"
      system "scp #{user}@#{domain}:~/hunchcrunch.sql ~/hunchcrunch.sql"
      system "mysql -u root -p hunchcrunch_development < ~/hunchcrunch.sql"
    end
  end
end