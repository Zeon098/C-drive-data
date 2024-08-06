package Library;

import java.util.Scanner;

public class RetrunBook implements IOOperation{


    @Override
    public void oper(DataBase dataBase, User user) {
        System.out.println("Enter book name: ");
        Scanner s=new Scanner(System.in);
        String bookname = s.next();
        if(!dataBase.getBrws().isEmpty())
        {
            for (Borrowing b : dataBase.getBrws())
            {
                if (b.getBook().getName().matches(bookname) &&
                        b.getUser().getName().matches(user.getName())) {

                    Book book = b.getBook();
                    int i = dataBase.getAllBooks().indexOf(book);
                    if (b.getDaysleft() < 0) {
                        System.out.println("You are late!\n"
                                + "You have to pay " + Math.abs(b.getDaysleft() * 50) + " as fine\n");
                    }
                    book.setBrwcopies(book.getBrwcopies() + 1);
                    dataBase.returnBook(b, book, i);
                    System.out.println("Book returned \nThank you!\n");
                    break;
                } else
                {
                    System.out.println("You didn't borrow this book!\n");
                }
            }
        }
        else
        {
            System.out.println("You didn't borrow this book!\n");
        }
        user.menu(dataBase);
    }
}
