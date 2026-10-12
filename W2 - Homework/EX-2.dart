class BankAccount {
    // TODO
    final int _accountId;
    final String _accountOwner;
    double _balance;

    BankAccount(this._accountId, this._accountOwner, [this._balance = 0.0]);

    int get accountId => _accountId;
    String get accountOwner => _accountOwner;

    double get balance => _balance;

    void withdraw(double amount) {
        if (amount <= 0) throw Exception('Withdrawal amount must be greater than zero!');
        if (_balance - amount < 0) throw Exception('Insufficient balance for withdrawal!');
        _balance -= amount;
    }

    void credit(double amount) {
        if (amount <= 0) throw Exception('Credit amount must be greater than zero!');
        _balance += amount;
    }

    // When printing the list of bank accounts from Bank
    @override
    String toString() => 'BankAccount(ID: $_accountId, Owner: $_accountOwner, Balance: \$$_balance)';
}

class Bank {
    // TODO
    final String _name;
    final List<BankAccount> _accounts = [];

    Bank({required String name}) : _name = name;

    String get name => _name;
    List<BankAccount> get accounts => _accounts;

    BankAccount createAccount(int accountId, String accountOwner) {
        for (var account in _accounts) {
            if (account.accountId == accountId) {
                throw Exception('Account with ID $accountId already exists!');
            }
        }

        final newAccount = BankAccount(accountId, accountOwner);
        _accounts.add(newAccount);
        return newAccount;
    }
}
 
void main() {

  Bank myBank = Bank(name: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  print(ronanAccount.balance); // Balance: $0
  ronanAccount.credit(100);
  print(ronanAccount.balance); // Balance: $100
  ronanAccount.withdraw(50);
  print(ronanAccount.balance); // Balance: $50

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}
