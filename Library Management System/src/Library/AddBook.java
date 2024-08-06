package Library;

import java.util.Scanner;

public class AddBook implements IOOperation {

    @Override
    public void oper(DataBase dataBase, User user) {
        Scanner s = new Scanner(System.in);
        Book book = new Book();
        System.out.println("Enter Book name: \n");
        String name = s.next();
        if(dataBase.getBook(name)>-1) {
            System.out.println("There is a book with this name!\n");
            user.menu(dataBase);
            return;
        }else {
            book.setName(name);
            System.out.println("Enter Auther name: ");
            book.setAuthor(s.next());
            System.out.println("Enter book collection address: ");
            book.setAdress(s.next());
            System.out.println("Enter Qty: ");
            book.setQty(s.nextInt());
            System.out.println("Enter price: ");
            book.setPrice(s.nextDouble());
            System.out.println("Enter borrowing copies: ");
            book.setBrwcopies(s.nextInt());
            dataBase.AddBook(book);
            System.out.println("Book Added successfully.");
            user.menu(dataBase);
            s.close();
        }

    }
}
