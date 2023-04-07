class ResourceToken < ApplicationToken
  def initialize(record)
    @record = record
    super()
  end

  private

  def payload
    key = "#{@record.class.name.underscore}_id"
    super.merge(key => @record.id)
  end
end
