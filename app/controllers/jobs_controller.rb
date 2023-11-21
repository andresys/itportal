class JobsController < ApplicationController
  def show
    p "=========="
    p status = ActiveJob::Status.get(params[:id]).status
    render json: { status: status }
  end

  def index
    p "==========="
    p stats = Sidekiq::Stats.new
    p stats.queues
    p stats.enqueued
    p stats.processed
    p stats.failed

    p scheduled_queue = Sidekiq::ScheduledSet.new
    p retry_queue = Sidekiq::RetrySet.new

    default_queue = Sidekiq::Queue.new("default")

    default_queue.each do | job |
      class_arg = job.args[0].split('-').select { | arg  | arg.match(' !ruby/class')  }[0]
      
      p class_arg.split[1].gsub '\'', '' unless class_arg.nil?
    end
    render json: { status: status }
  end
end