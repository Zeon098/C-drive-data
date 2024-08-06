package Library;

import java.util.Scanner;

public class CalculateFine implements IOOperation {
    @Override
    public void oper(DataBase dataBase, User user) {
        System.out.println("Enter book name: ");
        Scanner s = new Scanner(System.in);
        String bookname = s.next();

        boolean g= true;
        for (Borrowing b : dataBase.getBrws()) {
            if (b.getBook().getName().matches(bookname) &&
                    b.getUser().getName().matches(user.getName())) {
                System.out.println(b.getDaysleft());
                if(b.getDaysleft()>0){
                    System.out.println("You are late!\n"
                    +"You have to pay "+ b.getDaysleft()*50+" as fine\n");
                }else {
                    System.out.println("You don't have to pay fine\n");
                }
                g=false;
                break;

            }
        }

        if(g){
            System.out.println("You didn't borrow this book!");
        }
        user.menu(dataBase);


    }
}
