package Library;

import java.util.ArrayList;
import java.util.Scanner;

public class ViewOrders implements IOOperation{
    @Override
    public void oper(DataBase dataBase,User user) {
        System.out.println("\nEnter book name: ");
        Scanner s= new Scanner(System.in);
        String bookname=s.next();
        int i= dataBase.getBook(bookname);
        if(i<=-1){
            System.out.println("Book\t\tUser\t\tPrice\t\tQty\t\tPrice");
//            ArrayList<Order> orders =new ArrayList<Order>();
            for (Order order :dataBase.getAllOrders()){
                if(order.getBook().getName().matches(bookname)){
                    System.out.println(order.getBook().getName()+"\t\t"+order.getUser().getName()+
                            "\t\t"+order.getQty()+"\t"+order.getPrice());
                }

            }
            System.out.println();

        }else {
            System.out.println("book doesn't exist!");
        }
        user.menu(dataBase);
    }
}
