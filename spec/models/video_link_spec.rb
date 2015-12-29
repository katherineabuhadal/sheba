require 'spec_helper'

describe VideoLink do

  # Associations
  it { should belong_to :post }

  # Validations
  it { should validate_presence_of :post }

end
