# Coding Challenge Nearcut

> A single page app for uploading user data.

## Technologies Used

- Ruby on Rails
- Rubocop for linting
- Prettier for formating
- `heroku` for App deployment
- Rspec for testing

## Development (Running locally)

- Clone the project

```bash
git clone https://github.com/bolah2009/nearcut-csv-user.git

```

- Install Dependencies

```bash
bundle install
```

- Run Migration with

```bash
bundle exec rails db:migrate
```

- Setup your database with:

```bash
bundle exec rails db:setup
# this command will create the database, load the schema, and initialize it with the seed data.
```

- Start the server using:

```bash
rails server
```

Open the [localhost](http://localhost:3000/)

## Using with the deployed version

### Live link

- [Demo link](https://nearcut-csv-user.herokuapp.com/)

Visit the homepage to access the app.

## Validation and assumptions used in the coding challenge

The user entity attribute is validated using the following criteria:

1. name: The field is requried

2. password: The field is required and must be "strong"

   - A password is considered "strong" if all of the following conditions are met:
   - It has at least 10 characters and at most 16 characters.
   - It contains at least one lowercase character, one uppercase character and one digit.
   - It cannot contain three repeating characters in a row (e.g. "...zzz..." is not strong, but "...zz...z..." is strong, assuming other conditions are met).

   - Example of "strong" passwords

   ```
       • Aqpfk1swods
       • QPFJWz1343439
       • PFSHH78KSM
   ```

   - Example of not "strong" passwords

   ```
   	• Abc123 (this is too short)
       • abcdefghijklmnop (this does not contain an uppercase character or a digit)
       • AAAfk1swods (this contains three repeating characters, namely AAA)
   ```

## Implementation details

- The `StrongChecker` class is used to check string for strong criteria using regex and transversing the string for repetition. This class gives the no of changes required to be made.

- The `UserRegistrationService` class service accepts a file path and tries read the path line by line, the data in each line is used to create a User model and error/succes is been store according to be returned by the class.

- The `User` model uses a custom validation class to check if the password is strong and produces a custom error message.

- The `CsvServiceController` handles the request for `root` and file upload. The controller calls the `UserRegistrationService` with the file path and renders the result to the page.

### Limitations

1. The password check did not cover some edge cases.

- when the chars are symbol, it counts is as a valid char hence calculated with the length of the password.
- when a password length is `nil` or an emtpy string, it returns 10 chnages (which is the minimum changes required), the model validation is however blocking this since the password is required.

2.  the test can cover more edge cases, particularly the negative cases like when a user uploads a file other than csv (this is controlled on the frontend only)

In summary, I believe there are other improvements that could be made.

### Testing

Unit test is used for the `StrongChecker` class while the routing and request test is used for testing the app request and reponse flow. Model test is added for the `User` model to check the validation of the two attributes (`name` and `password`). Feature test is also added to mimick user's interaction with the app.

#### QA

To run the automated test, run

```
rspec --force-color --format documentation
```

To run Rubocop by itself, you may run the lint task:

```bash
rubocop
```

Or to automatically fix issues found (where possible):

```bash
rubocop -a
```

You can also check against Prettier:

```bash
npx prettier  --check "**/*.{html,md,json,yaml,yml}"
```

and to have it fix (to the best of its ability) any format issues, run:

```bash
npx prettier  --write "**/*.{html,md,json,yaml,yml}"
```

## 👤 Author

- Github: [@bolah2009](https://github.com/bolah2009)
- Twitter: [@bolah2009](https://twitter.com/bolah2009)
- Linkedin: [@bolah2009](https://www.linkedin.com/in/bolah2009/)

## 📝 License

[MIT licensed](./LICENSE).
