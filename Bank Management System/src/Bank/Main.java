package Bank;

import java.util.Scanner;

public class Main {
    static Scanner s;
    static DataBase database;

    public static void main(String[] args) {
        s = new Scanner(System.in);
        database = new DataBase();
        System.out.println("Welcome to Punjab Bank of Pakistan! ");
        System.out.println("\nEnter your login information!");
        login();
    }

    private static void login() {

        System.out.println("Enter your username : ");
        String username = s.next();
        System.out.println("Enter your password : ");
        String password = s.next();
        int n = database.login(username, password);
        if (n != -1) {
            User user = database.getUser(n);
            user.menu(database,user);
        } else {
            System.out.println("User don't exist! ");
        }
    }

     void newUser() {
        Account account= new Account();

        System.out.println("1. Manager\n2. Costumer");


        int n2 = s.nextInt();
        User user;
        if (n2 == 1) {
            System.out.println("Enter Username : ");
            String username = s.next();
            if (database.userExists(username)) {
                System.out.println("User exists");
                newUser();
            }
            account.setUsername(username);
            System.out.println("Enter password : ");
            String password = s.next();
            account.setPassword(password);
            user = new Manager(username, password);
        } else {
            System.out.println("Enter Username : ");
            String username = s.next();
            if (database.userExists(username)) {
                System.out.println("User exists");
                newUser();
            }
            account.setUsername(username);
            System.out.println("Enter password : ");
            String password = s.next();
            account.setPassword(password);
            System.out.println("Enter Phone/Account number : ");
            account.setAccNo(s.next());
            System.out.println("Enter cash you want to deposit : ");
            account.setBalance(s.nextInt());
            user = new NormalUser(username, password);
        }
        System.out.println("Account created successfully!");
        database.addUser(user);
        database.AddAccount(account);
    }

}