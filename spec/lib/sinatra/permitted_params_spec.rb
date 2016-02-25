require 'spec_helper'

describe Sinatra::PermittedParams do
  include Rack::Test::Methods

  class Dummy
    def self.foo(params); end
  end

  class DummyController < Sinatra::Base
    helpers Sinatra::PermittedParams

    get '/test_permitted_params' do
      Dummy.foo(testing_permitted_params)
    end

    get '/test_ignored_params' do
      Dummy.foo(testing_ignored_params)
    end

    def testing_permitted_params
      permitted_params([:name, :code])
    end

    def testing_ignored_params
      permitted_params([:name, :code], ignore: [:address])
    end
  end


  context 'when the request contains only permitted params' do
    it 'does not raise an error' do
      attributes = { 'name' => 'Joe', 'code' => 'ERF' }

      expect(Dummy).to receive(:foo).with(attributes)

      get '/test_permitted_params', attributes
    end
  end

  context 'when the request contains a not permitted param' do
    it 'raises an error' do
      expect do
        get '/test_permitted_params', 'invalid' => 'param'
      end.to raise_error(
        Sinatra::PermittedParams::UnpermittedParamsError,
        'Unpermitted params found: invalid'
      )
    end
  end

  context 'when there are keys to ignore' do
    it 'filters the declared params to ignore' do
      attributes = { 'name' => 'Joe', 'code' => 'ERF', 'address' => 'Av. Aragon' }
      expected_attributes = attributes.delete_if { |k, _| k == 'address' }

      expect(Dummy).to receive(:foo).with(expected_attributes)

      get '/test_ignored_params', attributes
    end
  end
end

def app
  DummyController.new
end
