require 'rails_helper'

RSpec.describe 'csv_service /', type: :feature do
  it 'renders a form for csv upload' do
    visit '/'
    within 'form' do
      expect(page).to have_field 'csv'
    end
  end

  context 'when csv is uploaded' do
    before do
      visit '/'
      within 'form' do
        attach_file 'csv', 'users.csv'
        click_on 'Submit'
      end
    end

    it 'shows the result header' do
      within 'section.results' do
        expect(page).to have_selector 'h3', text: "Result of user's upload"
      end
    end

    it 'shows a succesfully saved user' do
      within 'section.results ul.result-list' do
        expect(page).to have_selector 'li', text: 'Muhammad was successfully saved'
      end
    end

    it 'shows a user with one changes required' do
      within 'section.results ul.result-list' do
        expect(page).to have_selector 'li', text: "Change 1 character of Maria Turing's password"
      end
    end

    it 'shows a user with more than one changes required' do
      within 'section.results ul.result-list' do
        expect(page).to have_selector 'li', text: "Change 5 characters of Axel's password"
      end
    end
  end
end
