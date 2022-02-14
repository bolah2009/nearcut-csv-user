module Nearcut
  class StrongChecker
    attr_reader :input, :changes, :repeat_count

    def initialize(input)
      @input = input
      @changes = { repeat_count: 0 }
      @repeat_count = []
      track_change
    end

    def no_of_changes
      total_changes = changes.values.sum
      return 10 if total_changes > 10 && (input.length < 10) # minimum changed required

      total_changes
    end

    private

    def track_change
      return changes[:insert_delete] = 10 if input.blank?

      check_lowercase
      check_uppercase
      check_digit
      check_length
      input.each_char { |c| check_repeat c }
    end

    def check_repeat(char)
      repeat_count.clear if repeat_count.present? && (repeat_count.last != char)
      repeat_count.push(char)
      changes[:repeat_count] += 1 if repeat_count.length == 3
    end

    def check_length
      return if input.length.between?(10, 16)

      insertion = 10 - input.length
      deletion = input.length - 16

      changes[:insert_delete] = insertion.positive? ? insertion : deletion
    end

    def check_lowercase
      changes[:lowercase] = 1 unless /[[:lower:]]/.match?(input)
    end

    def check_uppercase
      changes[:uppercase] = 1 unless /[[:upper:]]/.match?(input)
    end

    def check_digit
      changes[:digit] = 1 unless /[[:digit:]]/.match?(input)
    end
  end
end
