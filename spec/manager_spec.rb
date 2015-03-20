require_relative 'spec_helper'
require 'hypercube/manager'

describe Hypercube::Manager do
  subject(:manager){ Hypercube::Manager.new }
  let(:vm){ 'bobbyzzz' }

  it 'finds its ass with two hands' do
    expect(manager.backend).to be Hypercube::Backend::VirtualBox
  end

  it 'basic vm lifecycles' do
    manager.run [:create, vm]
    create_list = manager.run 'list'
    manager.run [:destroy, vm]
    destroy_list = manager.run 'list'

    expect(create_list).to match /#{vm}/
    expect(destroy_list).not_to match /#{vm}/
  end

  context 'with vm' do
    before do
      manager.run [:create, vm]
    end

    after do
      manager.run [:destroy, vm]
    end

    context 'vm info' do
      subject(:info){ manager.run ['info', vm] }

      it 'displays info' do
        expect(info).to match /#{vm}/
      end

      it 'displays hd info' do
        pending "not implemented"
        manager.run ['set', vm]
      end
    end

    context 'modify vm' do
      it 'sets hard drives' do
        pending "not implemented"
        manager.run ['set', vm]
      end
    end
  end
end
