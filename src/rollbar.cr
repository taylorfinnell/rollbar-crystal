require "./rollbar/*"

module Rollbar
  class_property notifier : Notifier | Nil

  def self.notifier
    @@notifier ||= Notifier.new
  end

  def self.configure(&block)
    yield configuration
  end

  def self.configuration
    notifier.configuration
  end

  def self.info(message : String)
    notifier.report("info", message, nil)
  end

  def self.error(exception : Exception)
    notifier.report("error", nil, exception)
  end
end
