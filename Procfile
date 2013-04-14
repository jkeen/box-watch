# Run this with:
# gem install foreman && foreman start -f spec/Procfile

web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
# worker: bundle exec sidekiq -e production -C config/sidekiq.yml
