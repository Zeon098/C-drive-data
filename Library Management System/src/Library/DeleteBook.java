package Library;

import java.util.Scanner;

public class DeleteBook implements IOOperation{
    @Override
    public void oper(DataBase dataBase,User user) {
        Scanner s=new Scanner(System.in);
        System.out.println("Enter book name: ");
        String bookname=s.next();
        int i = dataBase.getBook(bookname);
        if(i>-1){
            dataBase.deleteBook(i);
            System.out.println("Book deleted successfully!\n");
        }else {
            System.out.println("Book doesn't exist!\n");
        }

        user.menu(dataBase);
        
    }
}
