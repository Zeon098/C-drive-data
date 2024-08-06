package Library;

import java.util.Scanner;

public class BorrowBook implements IOOperation {
    @Override
    public void oper(DataBase dataBase, User user) {
        Scanner s = new Scanner(System.in);
        System.out.println("Enter book name: ");
        String bookname = s.next();
        int i = dataBase.getBook(bookname);
        if (i > -1) {
            Book book = dataBase.getBook(i);
            boolean n = true;
            for (Borrowing b : dataBase.getBrws()) {
                if (b.getBook().getName().matches(bookname) &&
                        b.getUser().getName().matches(user.getName())) {
                    n = false;
                    System.out.println("You have borrowed this book before!\n");
                }

            }
            if(n) {

                if (book.getBrwcopies() > 1) {
                    Borrowing borrowing = new Borrowing(book, user);
                    book.setBrwcopies(book.getBrwcopies() - 1);
                    dataBase.borrowBook(borrowing, book, i);
                    System.out.println("You must return the book before 14 days from now\nExpiry date: "
                            + borrowing.getFinish() + "\nEnjoy!\n");

                } else {
                    System.out.println("This book isn't available for borrowing");
                }
            }
        } else {
            System.out.println("Book doesn't exist!\n");
        }
        user.menu(dataBase);
    }
}
