# frozen_string_literal: true

class ApplicationService
  def self.call(...)
    new(...).call
  end

  def initialize(*_); end
end
