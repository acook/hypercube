require_relative 'spec_helper'
require 'hypercube/manager'

describe Hypercube::Manager do
  subject(:manager){ Hypercube::Manager.new }
  let(:vm){ 'bobbyzzz' }

  it 'finds its ass with two hands' do
    manager.backend.should == Hypercube::Backend::VirtualBox
  end

  it 'basic vm lifecycles' do
    manager.run ['create', vm]
    create_list = manager.run 'list'
    manager.run ['destroy', vm]
    destroy_list = manager.run 'list'

    create_list.should =~ /#{vm}/
    destroy_list.should_not =~ /#{vm}/
  end

  context 'with vm' do
    before do
      manager.run ['create', vm]
    end

    after do
      manager.run ['destroy', vm]
    end

    context 'vm info' do
      subject(:info){ manager.run ['info', vm] }

      it 'displays info' do
        info.should =~ /#{vm}/
      end

      xit 'displays hd info' do
      end
    end

    context 'modify vm' do
      it 'sets hard drives' do
        #mananger.run ['set', vm]
        binding.pry
      end
    end
  end
end
