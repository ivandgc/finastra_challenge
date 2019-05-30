class Customer < ApplicationRecord
  NON_VALIDATABLE_ATTRS = ["id", "created_at", "updated_at"] #or any other attribute that does not need validation
  VALIDATABLE_ATTRS = Customer.attribute_names.reject{|attr| NON_VALIDATABLE_ATTRS.include?(attr)}

  validates_presence_of VALIDATABLE_ATTRS
  validates_uniqueness_of :name

  def keyword
    self.query_type == 'all' ? 'bank+atm' : self.query_type
  end
end
