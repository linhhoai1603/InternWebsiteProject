package services.application;

import java.util.Random;

public class Code {
    static Random rand = new Random();
    public static int createCode(){
        String rs = "";
        for (int i = 0; i < 6; i++) {
            rs += rand.nextInt(10);
        }
        return Integer.parseInt(rs);
    }
}