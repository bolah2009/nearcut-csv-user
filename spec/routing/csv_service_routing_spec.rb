require 'rails_helper'

RSpec.describe CsvServiceController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(post: '/').to route_to('csv_service#index')
    end
  end
end
