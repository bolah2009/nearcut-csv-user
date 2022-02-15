require 'rails_helper'

RSpec.describe CSVServiceController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(post: '/').to route_to('users#index')
    end
  end
end
