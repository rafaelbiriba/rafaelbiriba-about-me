task :server do
  sh "open 'http://127.0.0.1:4000/' && bundle exec jekyll serve -c config/jekyll_config.yml --watch --drafts"
end

desc "Compile production jekyll"
task :compile_production do
  %x(rm -rf _site_production/* && bundle exec jekyll build -c config/jekyll_config.yml,config/jekyll_config_production.yml)
end