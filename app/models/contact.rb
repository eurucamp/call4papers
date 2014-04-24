class Contact
  include ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :feedback

  def persisted?
    false
  end
end
