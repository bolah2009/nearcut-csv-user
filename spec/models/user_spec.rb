require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user, name: 'Bola') }

  context 'with validations' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:password) }

    context 'with password' do
      it { is_expected.to validate_presence_of(:password) }

      context 'with strong password' do
        it do
          expect(user)
            .to allow_values(*%w[Aqpfk1swods QPFJWz1343439 PFSHH78KSMa ghjAjfj582 ghjAjfj58295gj5H])
            .for(:password)
        end
      end

      context 'with weak password that requires 1 change' do
        it do
          expect(user)
            .not_to allow_values(*%w[Abc123asd Abc123asdjdksowmd AAAfk1swods DJDJ57JJDJ djdd7hdjd4 JdlslSGaogHSuhKS])
            .for(:password)
            .with_message("Change 1 character of Bola's password")
        end
      end

      context 'with weak password that requires 2 change' do
        let(:allowed_values) do
          %w[63738382728 GHDHD*@*@**@HDH
             djjdhdkk&@*@*ndn SSS728378218
             aaahffjnslfoif9 LLLlfkfkfkkgD]
        end

        it do
          expect(user)
            .not_to allow_values(*allowed_values)
            .for(:password)
            .with_message("Change 2 characters of Bola's password")
        end
      end

      context 'with weak password that requires 4 changes' do
        it do
          expect(user)
            .not_to allow_values(*%w[Abc123 @@@(@*@!*(#)])
            .for(:password)
            .with_message("Change 4 characters of Bola's password")
        end
      end

      context 'with weak password that requires 5 changes' do
        it do
          expect(user)
            .not_to allow_value('000aaaBBBccccDDD')
            .for(:password)
            .with_message("Change 5 characters of Bola's password")
        end
      end
    end
  end
end
