class JobChannel < ApplicationCable::Channel
  def subscribed
    stream_from "job_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
