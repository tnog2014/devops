lock '3.3.5'
set :application, 'user-manage' # アプリケーション名
set :repo_url, 'https://github.com/tnog2014/user-management.git' # リソース取得元のリポジトリ
set :branch, 'develop' # リソース取得元リポジトリのブランチ名
set :deploy_to, "/home/vagrant/um" #デプロイ先ディレクトリ
set :scm, :git # capistrano3からgitオンリーになった気がするのでいらないかも?

set :format, :pretty
set :log_level, :info # ログレベル(info/debug)
set :keep_releases, 3 # 保持するリリースの世代

set :npm, 'npm' # npmコマンド 

set :pid_file_name, 'my_app.pid' # PIDファイル名
set :pid_file, "/home/#{fetch(:user)}/.forever/pids/#{fetch(:pid_file_name)}" # PIDファイルパス

set :rel_app_path, 'bin/www' # 起動するアプリケーションの相対パス 

namespace :deploy do

  task :starting do
    puts "deploy:starting"
  end

  task :started do
    puts "deploy:started"
  end

  task :updating do
    puts "deploy:updating"
  end

  task :updated do
    puts "deploy:updated"
  end

  task :publishing do
    puts "deploy:publishing"
  end

  task :published do
    puts "deploy:published"
  end

  task :finishing do
    puts "deploy:finishing"
  end

  task :finished do
    puts "deploy:finished"
  end
  
  desc '起動に必要なnodeモジュールをnon-globalにインストールする。'
  task :npm_install do
    puts "nodeモジュールインストール"
    on roles(:app) do
      execute "cd #{release_path} && npm install"
    end
  end
 
  desc 'ユーザーが登録されていない場合に、デフォルト管理ユーザーを登録する。'
  task :init_db do
    puts "デフォルト管理ユーザーの追加"
    on roles(:app) do
      upload! "resource/initialize_users.js", "#{release_path}/initialize_users.js"
      out = capture "cd #{release_path} && mongo users initialize_users.js"
      puts out
    end
  end

  after :npm_install, 'deploy:init_db'

  desc 'アプリケーションを起動する。'
  task :start do
    puts "アプリケーション起動"
    on roles(:app) do
      within current_path do
        execute :forever, 'start', '--pidFile', fetch(:pid_file_name), "#{current_path}/#{fetch(:rel_app_path)}"
      end
    end
  end

  desc 'アプリケーションを停止する。'
  task :stop do
    puts "アプリケーション停止"
    on roles(:app) do
      within current_path do
        execute :forever, 'stop', "#{current_path}/#{fetch(:rel_app_path)}"
      end
    end
  end

 desc 'アプリケーションを再起動する。'
  task :restart do
    puts "アプリケーション再起動"
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        if test("[ -e #{fetch(:pid_file)} ]") && execute("kill -0 `cat #{fetch(:pid_file)}` > /dev/null 2>&1")
          execute :forever, 'restart', '--pidFile', fetch(:pid_file_name), "#{current_path}/#{fetch(:rel_app_path)}"
        else
          execute :forever, 'start', '--pidFile', fetch(:pid_file_name), "#{current_path}/#{fetch(:rel_app_path)}"
        end
      end
    end
  end

  before :updated, 'deploy:npm_install'
end


