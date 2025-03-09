package services.application;

public class Teleport {
    public String teleport(int k, String text) {
        StringBuilder result = new StringBuilder();
        for (char c : text.toCharArray()) {
            if (Character.isUpperCase(c)) {
                char in = (char) (((c - 'A' + k) % 26) + 'A');
                result.append(in);
            }
            else if (Character.isLowerCase(c)) {
                char in = (char) (((c - 'a' + k) % 26) + 'a');
                result.append(in);
            } else {
                result.append(c);
            }
        }
        return result.toString();
    }

    public static void main(String[] args) {
        Teleport t = new Teleport();
        String encypt = t.teleport(3, "Hello World");
        System.out.println(encypt);
        String decypt = t.teleport(-3, encypt);
        System.out.println(decypt);
    }
}
