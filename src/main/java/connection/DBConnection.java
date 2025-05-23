
package connection;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Query;

public class DBConnection {
    static Jdbi jdbi;


    public static Jdbi getJdbi() {
        if (jdbi == null) {
            getConnetion();
        }
        return jdbi;
    }


    // cung cấp kết nối Jdbi
    public static Jdbi getConnetion() {
        MysqlDataSource dataSource = new MysqlDataSource();
        dataSource.setURL("jdbc:mysql://"+ DBProperties.HOST+":"+DBProperties.PORT+"/"+DBProperties.NAME+"?"+DBProperties.OPTIONS);
        dataSource.setUser(DBProperties.USER);
        dataSource.setPassword(DBProperties.PASS);
        try {
            dataSource.setAutoReconnect(true);
            dataSource.setUseCompression(true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jdbi = Jdbi.create(dataSource); // tạo đối tượng Jdbi từ MysqlDataSource
    }

    public static void main(String[] args) {
        try {
            // Lấy kết nối Jdbi
            Jdbi jdbi = DBConnection.getJdbi();

            System.out.println("Đang thử kết nối đến database...");

            // Thực hiện truy vấn test đơn giản
            String result = jdbi.withHandle(handle -> {
                try (Query query = handle.createQuery("SELECT 1")) {
                    return query.mapTo(String.class).one();
                }
            });

            System.out.println("Kết nối thành công! Kết quả truy vấn test: " + result);

            // Hoặc test với version MySQL
            String version = jdbi.withHandle(handle ->
                    handle.createQuery("SELECT VERSION()")
                            .mapTo(String.class)
                            .one()
            );
            System.out.println("Phiên bản MySQL: " + version);

        } catch (Exception e) {
            System.err.println("Kết nối thất bại!");
            e.printStackTrace();

            // Kiểm tra thông tin kết nối
            System.err.println("\nThông tin kết nối:");
            System.err.println("URL: " + "jdbc:mysql://"+ DBProperties.HOST+":"+DBProperties.PORT+"/"+DBProperties.NAME+"?"+DBProperties.OPTIONS);
            System.err.println("User: " + DBProperties.USER);
        }
    }
}
