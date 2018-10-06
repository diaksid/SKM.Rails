set :output, 'log/cron.log'
job_type :rails, 'cd :path && :environment_variable=:environment rails :task :output'

every :day, at: '00:00' do
  rails 'sitemap:refresh', environment: 'production'
end
