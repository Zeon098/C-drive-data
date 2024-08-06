package Library;

import java.util.Scanner;

public class NormalUser extends User {
    public NormalUser(String name) {
        super(name);
        this.operations = new IOOperation[]{
                new Viewbooks(),
                new Search(),
                new PlaceOrder(),
                new BorrowBook(),
                new CalculateFine(),
                new RetrunBook(),
                new Exit(),

        };
    }

    public NormalUser(String name, String email, String phoneNumber) {
        super(name, email, phoneNumber);
        this.operations = new IOOperation[]
                {
                        new Viewbooks(),
                        new Search(),
                        new PlaceOrder(),
                        new BorrowBook(),
                        new CalculateFine(),
                        new RetrunBook(),
                        new Exit(),
                };
    }

    @Override
    public void menu(DataBase dataBase) {

        System.out.println("1. View Books");
        System.out.println("2. Search");
        System.out.println("3. Place Order");
        System.out.println("4. Borrow Book");
        System.out.println("5. Calculate Fine");
        System.out.println("6. Return Book");
        System.out.println("7. Exit");

        Scanner s = new Scanner(System.in);
        int n = s.nextInt();
        this.operations[n - 1].oper(dataBase, this);
        s.close();
    }

    @Override
    public String toString() {
        return name + "<N/>" + email + "<N/>" + phoneNumber + "<N/>" + "Normal";
    }
}
