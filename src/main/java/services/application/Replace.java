package services.application;

import java.util.HashMap;
import java.util.Map;

public class Replace {
    private final String ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private final String SUB =   "QRSTUVWXYZABCDEFGHIJKLMNOP";
    public Map<Character, Character> replace(boolean encrypt){
        Map<Character, Character> map = new HashMap<Character, Character>();
        for(int i=0; i<ALPHA.length(); i++){
            if(encrypt){
                map.put(Character.toLowerCase(ALPHA.charAt(i)), Character.toLowerCase(SUB.charAt(i)));
                map.put(Character.toUpperCase(ALPHA.charAt(i)), Character.toUpperCase(SUB.charAt(i)));
            }else{
                map.put(Character.toLowerCase(SUB.charAt(i)), Character.toLowerCase(ALPHA.charAt(i)));
                map.put(Character.toUpperCase(SUB.charAt(i)), Character.toUpperCase(ALPHA.charAt(i)));
            }
        }
        return map;
    }
    public String replace(String text, boolean encrypt){
        Map<Character, Character> map = replace(encrypt);
        StringBuilder result = new StringBuilder();
        for(char c : text.toCharArray()){
            if(map.containsKey(c)){
                result.append(map.get(c));
            }else{
                result.append(c);
            }
        }
        return result.toString();
    }

    public static void main(String[] args) {
        Replace replace = new Replace();
        String text = "Huynh Linh Hoai";
        String encrypt = replace.replace(text, true);
        System.out.println(encrypt);
        String decrypt = replace.replace(encrypt, false);
        System.out.println(decrypt);
    }
}
