package Bank;

import java.util.ArrayList;
import java.util.Scanner;

public class Manager extends User{
    public Manager(String username, String password) {
        super(username, password);
    }
    public Manager(String username, String password,String accNo,int balance) {
        super(username, password, accNo, balance);
    }

    @Override
    public String toString() {
        return username + "<N/>" + password + "<N/>" + "Manager";
    }

    @Override
    public void menu(DataBase dataBase, User user) {
        System.out.println("1. Add New User Account");
        System.out.println("2. Add Cash to User Account");
        System.out.println("3. Remove User Account");
        System.out.println("4. View all accounts");
        System.out.println("5. Exit (Close this application)");

        Scanner s = new Scanner(System.in);
        int n = s.nextInt();
        switch (n) {
            case 1:
                Main main=new Main();
                main.newUser();
                user.menu(dataBase, this);
                break;
            case 2:
                addCashToUserAccount(dataBase, this);
                break;
            case 3:
                removeUser(dataBase, this);
                break;
            case 4:
                viewAllAccounts(dataBase, this);
            case 5:
                return;
            default:
                System.out.println("Enter valid input!");
                user.menu(dataBase, this);
        }
    }
    public void removeUser(DataBase dataBase,User user) {
        Scanner s=new Scanner(System.in);
        System.out.println("Enter Username: ");
        String username=s.next();
        int i = dataBase.getUser(username);
        if(i>-1){
            dataBase.deleteUser(i);
            dataBase.deleteAccount(i);
            System.out.println("Account deleted successfully!\n");
        }else {
            System.out.println("Account doesn't exist!\n");
        }

        user.menu(dataBase,this);

    }
    public void addCashToUserAccount(DataBase dataBase,User user){
        Scanner s = new Scanner(System.in);
        System.out.println("Enter amount you want to deposit : ");
        int amount=s.nextInt();
        ArrayList<Account> accounts = dataBase.getAllAccounts();

        for (Account a : accounts)
        {
            if(user.getUsername().matches(a.getUsername())) {
                a.setBalance(a.getBalance()+amount);
            }
        }
        dataBase.saveAccounts();
        System.out.println(amount+" deposited successfully!\n\n");
        user.menu(dataBase, this);
    }


    public void viewAllAccounts(DataBase dataBase,User user) {
        ArrayList<Account> accounts = dataBase.getAllAccounts();
        System.out.println("Name\t\t\tPassword\t\tAccount Number\tBalance");
        for (Account a : accounts)
        {
            System.out.println(a.getUsername()+"\t\t"+a.getPassword()+"\t\t"+a.getAccNo()+"\t\t"+a.getBalance());
        }
        System.out.println();
        user.menu(dataBase,this);
    }


}
