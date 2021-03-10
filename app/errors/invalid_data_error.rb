class InvalidDataError < StandardError
  def initialize(errors = [])
    super
    @errors = errors
  end

  attr_reader :errors
end
