package Library;

import java.util.Scanner;

public class DeleteAllData implements IOOperation{
    @Override
    public void oper(DataBase dataBase,User user) {
        System.out.println("\nAre you sure that you want to delete all data?\n1. Continue\n2. Main menu");
        Scanner s=new Scanner(System.in);
        int i=s.nextInt();
        if (i==1){
            dataBase.deleteAllData();
        }else {
            user.menu(dataBase);
        }
    }
}
