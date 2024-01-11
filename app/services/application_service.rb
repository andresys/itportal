class ApplicationService
  def self.call(*args, &block)
    @@status = block
    new.call *args
  end

protected
  def set_status status
    @@status&.call status
  end
end