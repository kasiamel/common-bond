class ResponseError < ApplicationError
  attr_reader :status

  def initialize(status)
    super(status.to_s.titleize)
    @status = status
  end
end
