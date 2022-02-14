class StrongPasswordChecker < ActiveModel::Validator
  def validate(record)
    @changes_count = Nearcut::StrongChecker.new(record.password).no_of_changes
    return if @changes_count.zero?

    message = "Change #{@changes_count} #{character} of #{record.name}'s password"
    record.errors.add(:password, message)
  end

  private

  def character
    @changes_count == 1 ? 'character' : 'characters'
  end
end
