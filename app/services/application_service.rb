class ApplicationService
  def self.call(*args, &block)
    @@status = block
    new(*args).call
  end

  protected

  def set_status status
    p status
    @@status&.call status
  end
end