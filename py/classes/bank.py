class Account:
    def __init__(self, account_number, bal):
        self.account_number = account_number
        self.bal = bal

    def deposit(self, quantity):
        self.bal += quantity

    def withdraw(self, quantity):
        self.bal -= quantity


class Bank:
    company_name = "The Banky Bank"

    def __init__(self, branch_location):
        self.branch_location = branch_location
        self.accounts = {}

    def add_account(self, account: Account):
        if account.account_number in self.accounts:
            raise ValueError("Account with same number already exists!")

        self.accounts[account.account_number] = account

    def remove_account(self, account: Account):
        try:
            del self.accounts[account.account_number]
        except KeyError:
            raise ValueError("Account not part of bank!")

    def balance(self):
        """
        Computes sum total of all bank accounts.
        """
        total = 0
        for account in self.accounts.values():
            total += account.bal
        return total
