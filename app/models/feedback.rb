class Feedback
  include ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :feedback
  validates_presence_of :feedback

  def initialize(params = {})
    self.feedback = params[:feedback]
  end

  def persisted?
    false
  end
end
