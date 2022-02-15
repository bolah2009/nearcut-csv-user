module Nearcut
  class UserRegistrationService
    attr_reader :file_name, :results

    def initialize(file_name)
      @file_name = file_name
      @results = []
      save_to_db
    end

    private

    def save_to_db
      headers = %w[name password]
      File.foreach(file_name) do |line|
        current_line = line.strip.split(',')
        next if current_line[0] == headers[0] # skip file header

        name, password = current_line

        @user = User.create(name: name, password: password) # rubocop:disable Style/HashSyntax
        if @user.save
          results.push("#{name} was successfully saved")
        else
          results.push(@user.errors.objects.first.message)
        end
      end
    end
  end
end
