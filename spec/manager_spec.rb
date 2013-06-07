require_relative 'spec_helper'
require 'hypercube/manager'

describe Hypercube::Manager do
  subject(:manager){ Hypercube::Manager.new }

  it 'finds its ass with two hands' do
    manager.backend.should == Hypercube::Backend::VirtualBox
  end
end
