package test;

import dao.AccountDao;
import dao.CategoryDao;

public class Main {
    public static void main(String[] args) {
//        AccountDao dao = new AccountDao();
//        System.out.println(dao.findByUsername("linhhoai", "linhhoai"));
        CategoryDao dao = new CategoryDao();
        System.out.println(dao.findById(1));


    }
}
