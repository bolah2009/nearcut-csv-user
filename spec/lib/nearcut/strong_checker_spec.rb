require 'rails_helper'

describe Nearcut::StrongChecker do
  subject { described_class.new(params).no_of_changes }

  context 'with all conditions satified' do
    let(:expected_changes) { 0 }

    context 'with case - 1' do
      let(:params) { 'Aqpfk1swods' }

      it { is_expected.to eq expected_changes }
    end

    context 'with case - 2' do
      let(:params) { 'QPFJWz1343439' }

      it { is_expected.to eq expected_changes }
    end

    context 'with case - 3' do
      let(:params) { 'PFSHH78KSMa' }

      it { is_expected.to eq expected_changes }
    end

    context 'when string is exactly 10 char' do
      let(:params) { 'ghjAjfj582' }

      it { is_expected.to eq expected_changes }
    end

    context 'when string is exactly 16 char' do
      let(:params) { 'ghjAjfj58295gj5H' }

      it { is_expected.to eq expected_changes }
    end
  end

  context 'when length is less' do
    let(:params) { 'Abc123' }
    let(:expected_changes) { 4 }

    it { is_expected.to eq expected_changes }
  end

  context 'when length is less but close' do
    let(:params) { 'Abc123asd' }
    let(:expected_changes) { 1 }

    it { is_expected.to eq expected_changes }
  end

  context 'when length is more' do
    let(:params) { 'Abc123jdkdlslsnrbgjsfjfmdks' }
    let(:expected_changes) { 11 }

    it { is_expected.to eq expected_changes }
  end

  context 'when length is more but close' do
    let(:params) { 'Abc123asdjdksowmd' }
    let(:expected_changes) { 1 }

    it { is_expected.to eq expected_changes }
  end

  context 'when there is more than one repeated characters' do
    let(:params) { '000aaaBBBccccDDD' }
    let(:expected_changes) { 5 }

    it { is_expected.to eq expected_changes }
  end

  context 'when there is a repeated character' do
    let(:params) { 'AAAfk1swods' }
    let(:expected_changes) { 1 }

    it { is_expected.to eq expected_changes }
  end

  context 'when there is no lower case' do
    let(:params) { 'DJDJ57JJDJ' }
    let(:expected_changes) { 1 }

    it { is_expected.to eq expected_changes }
  end

  context 'when there is no upper case' do
    let(:params) { 'djdd7hdjd4' }
    let(:expected_changes) { 1 }

    it { is_expected.to eq expected_changes }
  end

  context 'when there is no digit' do
    let(:params) { 'JdlslSGaogHSuhKS' }
    let(:expected_changes) { 1 }

    it { is_expected.to eq expected_changes }
  end

  context 'when multiple conditions are not met' do
    context 'with upper and lower case not met' do
      let(:params) { '63738382728' }
      let(:expected_changes) { 2 }

      it { is_expected.to eq expected_changes }
    end

    context 'with digit and lower case not met' do
      let(:params) { 'GHDHD*@*@**@HDH' }
      let(:expected_changes) { 2 }

      it { is_expected.to eq expected_changes }
    end

    context 'with digit and upper case not met' do
      let(:params) { 'djjdhdkk&@*@*ndn' }
      let(:expected_changes) { 2 }

      it { is_expected.to eq expected_changes }
    end

    context 'with repeat and lower case not met' do
      let(:params) { 'SSS728378218' }
      let(:expected_changes) { 2 }

      it { is_expected.to eq expected_changes }
    end

    context 'with repeat and upper case not met' do
      let(:params) { 'aaahffjnslfoif9' }
      let(:expected_changes) { 2 }

      it { is_expected.to eq expected_changes }
    end

    context 'with digit and repeat not met' do
      let(:params) { 'LLLlfkfkfkkgD' }
      let(:expected_changes) { 2 }

      it { is_expected.to eq expected_changes }
    end

    context 'with upper case, lower case, digit and repeat not met' do
      let(:params) { '@@@(@*@!*(#)' }
      let(:expected_changes) { 4 }

      it { is_expected.to eq expected_changes }
    end
  end

  context 'with all conditions not met' do
    let(:expected_changes) { 10 }

    context 'with nil value' do
      let(:params) { nil }

      it { is_expected.to eq expected_changes }
    end

    context 'with empty string value' do
      let(:params) { '' }

      it { is_expected.to eq expected_changes }
    end

    context 'with non digit and word value' do
      let(:params) { '*@^' }

      it { is_expected.to eq expected_changes }
    end
  end
end
