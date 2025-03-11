package dao;

import connection.DBConnection;
import models.Category;
import models.Price;
import models.Product;
import models.TechnicalInfo;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class ProductDAO2 {
    private Jdbi jdbi;
    public ProductDAO2() {
        jdbi = DBConnection.getConnetion();
    }
    public List<Product> getAllProducts(int currentPage, int nuPerPage, String option) {
//        if(option.isBlank() || option.isEmpty() ){
//            option = "Bán chạy";
//        }
//        String condition = "1=1";
//        switch (option) {
//            case "Bán chạy":
//                condition = "";
//
//        }
        int offset = (currentPage - 1) * nuPerPage;
        String sql = """
        SELECT
            p.id, p.name, p.quantity, p.addedDate, p.description, p.area, p.selling, p.img,
            c.id AS category_id, c.name AS category_name,
            pr.id AS price_id, pr.price, pr.discountPercent, pr.lastPrice,
            ti.id AS technical_info_id, ti.specifications, ti.manufactureDate
        FROM
            products p
        JOIN
            categories c ON p.idCategory = c.id
        JOIN
            prices pr ON p.idPrice = pr.id
        LEFT JOIN
            technical_information ti ON p.idTechnical = ti.id
        ORDER BY p.id
        LIMIT :nuPerPage OFFSET :offset
    """;

        //String finalCondition = condition;
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("nuPerPage", nuPerPage)
                        .bind("offset", offset)
                        .map((rs, ctx) -> {
                            Product product = new Product();
                            product.setId(rs.getInt("id"));
                            product.setName(rs.getString("name"));
                            product.setQuantity(rs.getInt("quantity"));
                            product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                            product.setDescription(rs.getString("description"));
                            product.setArea(rs.getDouble("area"));
                            product.setSelling(rs.getInt("selling"));
                            product.setImage(rs.getString("img"));

                            Category category = new Category();
                            category.setId(rs.getInt("category_id"));
                            category.setName(rs.getString("category_name"));
                            product.setCategory(category);

                            TechnicalInfo technicalInfo = new TechnicalInfo();
                            technicalInfo.setId(rs.getInt("technical_info_id"));
                            technicalInfo.setSpecification(rs.getString("specifications"));
                            technicalInfo.setManufactureDate(rs.getDate("manufactureDate").toLocalDate());
                            product.setTechnicalInfo(technicalInfo);

                            Price price = new Price();
                            price.setId(rs.getInt("price_id"));
                            price.setPrice(rs.getDouble("price"));
                            price.setDiscountPercent(rs.getDouble("discountPercent"));
                            price.setLastPrice(rs.getDouble("lastPrice"));
                            product.setPrice(price);

                            return product;
                        })
                        .list()
        );
    }
    public List<Product> getProductByCategoryName(String nameCategory, int currentPage, int nuPerPage , String option) {

        int offset = (currentPage - 1) * nuPerPage;
        String sql = """
        SELECT
            p.id, p.name, p.quantity, p.addedDate, p.description, p.area, p.selling, p.img,
            c.id AS category_id, c.name AS category_name,
            pr.id AS price_id, pr.price, pr.discountPercent, pr.lastPrice,
            ti.id AS technical_info_id, ti.specifications, ti.manufactureDate
        FROM
            products p
        JOIN
            categories c ON p.idCategory = c.id
        JOIN
            prices pr ON p.idPrice = pr.id
        LEFT JOIN
            technical_information ti ON p.idTechnical = ti.id
        WHERE
            c.name = :categoryName
        ORDER BY p.id
        LIMIT :nuPerPage OFFSET :offset
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryName", nameCategory)
                        .bind("nuPerPage", nuPerPage)
                        .bind("offset", offset) // Chắc chắn truyền giá trị offset
                        .map((rs, ctx) -> {
                            Product product = new Product();
                            product.setId(rs.getInt("id"));
                            product.setName(rs.getString("name"));
                            product.setQuantity(rs.getInt("quantity"));
                            product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                            product.setDescription(rs.getString("description"));
                            product.setArea(rs.getDouble("area"));
                            product.setSelling(rs.getInt("selling"));
                            product.setImage(rs.getString("img"));

                            Category category = new Category();
                            category.setId(rs.getInt("category_id"));
                            category.setName(rs.getString("category_name"));
                            product.setCategory(category);

                            TechnicalInfo technicalInfo = new TechnicalInfo();
                            technicalInfo.setId(rs.getInt("technical_info_id"));
                            technicalInfo.setSpecification(rs.getString("specifications"));
                            technicalInfo.setManufactureDate(rs.getDate("manufactureDate").toLocalDate());
                            product.setTechnicalInfo(technicalInfo);

                            Price price = new Price();
                            price.setId(rs.getInt("price_id"));
                            price.setPrice(rs.getDouble("price"));
                            price.setDiscountPercent(rs.getDouble("discountPercent"));
                            price.setLastPrice(rs.getDouble("lastPrice"));
                            product.setPrice(price);

                            return product;
                        })
                        .list()
        );

    }
    public int countProducts() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM products")
                        .mapTo(Integer.class)
                        .one()
        );
    }
    public int countProductsByCategoryName(String categoryName) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM products p " +
                                "JOIN categories c ON p.idCategory = c.id " +
                                "WHERE c.name = :categoryName")
                        .bind("categoryName", categoryName) // Truyền tham số categoryName vào SQL
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public static void main(String[] args) {
        ProductDAO2 dao = new ProductDAO2();
        //System.out.println(dao.getAllProducts(1, 10,""));
        //System.out.println (dao.getProductByCategoryName("Vải may mặc",1, 10,""));
        //System.out.println(dao.countProducts());
        System.out.println(dao.countProductsByCategoryName("Dây kéo"));
    }

}
