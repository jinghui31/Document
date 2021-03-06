class Account:
    def __init__(self, name, number, balance):
        self.__name = name
        self.__number = number
        self.__balance = balance

    def deposit(self, amount):
        if amount <= 0:
            print('存款金額不得為負')
        else:
            self.__balance += amount

    def withdraw(self, amount):
        if amount > self.__balance:
            print('餘額不足')
        else:
            self.__balance -= amount

    def __str__(self):
        return "Account ('{name}', '{number}', {balanace})".format(
            name = self.__name, number = self.__number, balance = self.__balance
        )

class SavingAccount(Account):
    def __init__(self, name, number, balance, interest_rate):
        super().__init__(name, number, balance)
        self.__interest_rate = interest_rate
    
    def __str__(self):
        return (super().__str__() [0: -1] +
                str(self.__interest_rate))