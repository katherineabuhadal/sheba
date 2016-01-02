require 'spec_helper'

describe Recipe do

  # Associations
  it { should have_many :pictures }
  it { should have_many :comments }
  it { should have_one :video_link }

end
