require 'pusher'

Pusher.app_id = ENV["401683"]
Pusher.key = ENV["8802131a4ee4a9b8c56d"]
Pusher.secret = ENV["994aee948805986fade3"]
Pusher.cluster = 'ap1'
Pusher.logger = Rails.logger
Pusher.encrypted = true
