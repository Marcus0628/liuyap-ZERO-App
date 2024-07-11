import 'package:get/get.dart';
import 'package:zero/model/Transaction.dart';
import 'package:zero/pages/Profile/wallet.dart';
import 'package:zero/model/itemModel.dart';
import 'package:intl/intl.dart';

class WalletController extends GetxController {
  RxInt setAmountIndex = 0.obs;
  double balance = 0.0;
  RxList<Transaction> transactionHistory = <Transaction>[].obs;
  
  void addTopUpTransaction(double amount) {
    final now = DateTime.now();
    final newTransaction = Transaction(
      description: 'Top Up',
      amount: amount,
      date: DateFormat.yMd().add_jm().format(now),
      type: TransactionType.TopUp,
    );
    transactionHistory.insert(0, newTransaction);
  }

  void addPaymentTransaction(double amount) {
    final now = DateTime.now();
    final newTransaction = Transaction(
      description: 'Payment',
      amount: amount,
      date: DateFormat.yMd().add_jm().format(now),
      type: TransactionType.Payment,
    );
    transactionHistory.insert(0, newTransaction);
  }


  setIndex(index) {
    print(index);
    setAmountIndex.value = index;
    update();
  }

  void setAmount(double amount) {
    setAmountIndex.value = amount.toInt();
    update();
  }



  void topUpAmount(double amount) {
  balance += amount;
  addTopUpTransaction(amount); // Add the transaction to the history
  print('Topped up $amount. New balance: $balance');
  update(); // Notify listeners about the change
  }

  void deductPayment(String totalWithTax) {
    double amountToDeduct = double.parse(totalWithTax);
    if (balance >= amountToDeduct) {
      balance -= amountToDeduct;
      print('Deducted $amountToDeduct from the balance. New balance: $balance');
      addPaymentTransaction(amountToDeduct); // Add payment transaction
    } else {
      print('Insufficient balance to deduct $amountToDeduct');
    }
    update(); // Notify listeners about the change
  }
}


  


