require 'spec_helper'

describe Post do

  # Associations
  it { should have_many :pictures }
  it { should have_many :comments }
  it { should have_one :video_link }

end
