# Transactions App

**Flutter Technical Test**

This is an app that tracks the user's transaction.

These are the features the user will have access to inside the app:

- Transaction managment
  - Adding
  - Editing
  - Deleting
- Summary of transactions
  - Total income
  - Total expenses
  - Balance
- Persistent data

## Technical Features

- Implemented clean architecture principles
- State managed with `Riverpod`
  - This is because it offers enhanced state managment compared to setState or Provider. It also offers simpler interaction between multiple providers. Comes with different provider types with different purposes. Reduces boilerplate code on some implementations compared to other state managment tools
- Local storage managed with `SQLite`
  - This is because SQLite offers more secure and stable storage than SharedPreferences. SharedPreferences should be used only for non-valuable data such as preferences or tokens
- Contains dark mode
- Created using Flutter v3.24.3

## How to run the project

1. Clone the repository to your local machine

   - Clone `main` branch

2. Add `.env` file with variables

   - Follow `.env.template`
   - Works with any values passed in env file

3. Install packages with:

   ```
   flutter pub get
   ```

4. Run application with:
   ```
   flutter run
   ```
