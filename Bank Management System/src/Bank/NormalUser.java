package Bank;

import java.util.ArrayList;
import java.util.Scanner;

public class NormalUser extends User{
    public NormalUser(String username, String password) {
        super(username, password);
    }
    public NormalUser(String username, String password,String accNo,int balance) {
        super(username, password, accNo, balance);
    }
    @Override
    public String toString() {
        return username + "<N/>" + password + "<N/>" +  "Normal";
    }

    @Override
    public void menu(DataBase dataBase, User user) {
        System.out.println("1. View Account info.");
        System.out.println("2. Withdraw Money");
        System.out.println("3. Money Transfer");
        System.out.println("4. Check Balance");
        System.out.println("5. Exit (Close this application)");
        Scanner s = new Scanner(System.in);
        int n = s.nextInt();
        switch (n) {
            case 1:
                viewInfo(dataBase, this);
                break;
            case 2:
                withdraw(dataBase, this);
            case 3:
                moneyTransfer(dataBase, this);
            case 4:
                checkBalance(dataBase, this);
            case 5:
                return;
            default:
                System.out.println("Enter valid input!");
                user.menu(dataBase, this);
        }

    }
    public void viewInfo(DataBase dataBase,User user){
        ArrayList<Account> accounts = dataBase.getAllAccounts();

        for (Account a : accounts)
        {
            if(user.getUsername().matches(a.getUsername())){
                System.out.println("Account Name     :  "+a.getUsername());
                System.out.println("Account Password :  "+a.getPassword());
                System.out.println("Account Number   :  "+a.getAccNo());
                System.out.println("Account Balance  :  "+a.getBalance()+" Rs.");
            }
        }
        System.out.println();

        user.menu(dataBase, this);
    }

    public void withdraw(DataBase dataBase,User user){
        Scanner s = new Scanner(System.in);
        System.out.println("Enter amount you want to withdraw : ");
        int amount=s.nextInt();
        ArrayList<Account> accounts = dataBase.getAllAccounts();

        for (Account a : accounts)
        {
            if(user.getUsername().matches(a.getUsername())) {
                a.setBalance(a.getBalance()-amount);
            }
        }
        dataBase.saveAccounts();
        System.out.println(amount+" withdraw successful!\n\n");
        user.menu(dataBase, this);
    }
    public void checkBalance(DataBase dataBase,User user){
        ArrayList<Account> accounts = dataBase.getAllAccounts();

        for (Account a : accounts)
        {
            if(user.getUsername().matches(a.getUsername())) {
                System.out.println("Your account balance is : "+a.getBalance()+" Rs. \n\n");
            }
        }

        user.menu(dataBase, this);
    }
    public void moneyTransfer(DataBase dataBase,User user){
        Scanner s = new Scanner(System.in);
        System.out.println("Enter account number of recipient : ");
        String account=s.next();
        System.out.println("Enter amount you want to transfer : ");
        int amount=s.nextInt();
        int i=0;
        ArrayList<Account> accounts = dataBase.getAllAccounts();

        for (Account a : accounts) {
            if (a.getAccNo().matches(account)) {
                a.setBalance(a.getBalance() + amount);
                System.out.println(amount+" transferred successfully to !"+a.getUsername()+"\n\n");
                i=1;
            }
            if (user.getUsername().matches(a.getUsername())) {
                if(amount<=a.getBalance()){
                    a.setBalance(a.getBalance() - amount);
                }else {
                    System.out.println("Error! Low Balance");
                }

            }
        }
        if(i!=1){
            System.out.println("Error! Account not found");
        }
        dataBase.saveAccounts();
        user.menu(dataBase, this);
    }


}
