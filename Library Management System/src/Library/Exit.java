package Library;

import java.util.Scanner;

public class Exit implements IOOperation{
    Scanner s;
    DataBase dataBase;
    User user;
    @Override
    public void oper(DataBase dataBase,User user) {
        this.dataBase=dataBase;
        this.user=user;
        System.out.println("\nAre you sure that you want to quit?\n1. Yes\n2. Main menu");
        s=new Scanner(System.in);
        int i=s.nextInt();
        if (i==1){
            System.out.println("0. Exit\n" + "1. Login\n2. New User");
            s = new Scanner(System.in);
            int num = s.nextInt();
            switch (num) {
                case 1:
                    login();
                    break;
                case 2:
                    newuser();
                    break;
            }
        }
        else
        {
            user.menu(dataBase);
        }
    }
        private void login() {

            System.out.println("Enter your number : ");
            String phonenumber = s.next();
            System.out.println("Enter your email : ");
            String email = s.next();
            int n = dataBase.login(phonenumber, email);
            if (n != -1) {
                User user = dataBase.getUser(n);
                user.menu(dataBase);
            } else {
                System.out.println("User don't exist! ");
            }
        }

        private void newuser() {

            System.out.println("Enter name : ");
            String name = s.next();
            System.out.println("Enter your number : ");
            String phonenumber = s.next();
            System.out.println("Enter your email : ");
            String email = s.next();
            System.out.println("1. Admin\n2. Normal User");


            int n2 = s.nextInt();
            User user;
            if (n2 == 1) {
                user = new Admin(name, email, phonenumber);
            } else {
                user = new NormalUser(name, email, phonenumber);
            }
            dataBase.addUser(user);
            user.menu(dataBase);

        }
}
