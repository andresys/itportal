import consumer from "./consumer"

consumer.subscriptions.create("JobChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('Connected...')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log('Disconnected...')
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // console.log('Received data:', data)

    const job = document.getElementById('job_' + data['job_id'])
    if(!job) { return }
    
    if(data['job_item']) {
      const job_item = document.getElementById('job_item_' + data['job_id'])
      if(job_item) {job_item.innerHTML = data['job_item']}

      const job_progress = document.getElementById('job_progress_' + data['job_id'])
      if(job_progress && data['job_progress'] == null) { job_progress.remove() }
      if(job_progress == null && data['job_progress']) { job.after(this.html(data['job_progress'])) }

      const job_action = document.getElementById('job_action_' + data['job_id'])
      if(job_action) {job_action.innerHTML = data['job_action']}
    }
    
    if(data['procent']) {
      const progress = document.getElementById('progress_' + data['job_id'])
      if(progress) {progress.style.width = data['procent'] + '%'}
    }

    if(data['step']) {
      const step = document.getElementById('step_' + data['job_id'])
      if(step) {step.innerHTML = data['step']}

      const job_log_messages = document.getElementById('job_log_messages_' + data['job_id'])
      if(job_log_messages) {job_log_messages.innerHTML = data['messages']}
    }
  },

  html(htmlString) {
    const parser = new DOMParser()
    return parser.parseFromString(htmlString, 'text/html')
  }
});
