package dao;

import connection.DBConnection;
import models.Category;
import models.Price;
import models.Product;
import models.TechnicalInfo;
import org.jdbi.v3.core.Jdbi;

import java.time.LocalDate;
import java.util.List;

public class ProductDao {
    private Jdbi jdbi;
    public ProductDao() {
        jdbi = DBConnection.getConnetion();
    }
    public Product getProductById(int id ) {
        String sql = """
       SELECT
           p.id, p.name, p.quantity, p.addedDate, p.description, p.height, p.weight, p.width,, p.selling, p.img,
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
           p.id = :id;
    """;
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .map((rs, ctx) -> {

                            Category category = new Category();
                            category.setId(rs.getInt("category_id"));
                            category.setName(rs.getString("category_name"));

                            Product product = new Product();
                            product.setId(rs.getInt("id"));
                            product.setName(rs.getString("name"));
                            product.setQuantity(rs.getInt("quantity"));
                            product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                            product.setDescription(rs.getString("description"));
                            product.setHeight(rs.getDouble("height")); // Thêm trường height
                            product.setWeight(rs.getDouble("weight")); // Thêm trường weight
                            product.setWidth(rs.getDouble("width"));   // Thêm trường width
                            product.setSelling(rs.getInt("selling"));
                            product.setImage(rs.getString("img"));
                            product.setCategory(category); // Gắn Category vào Product

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
                        .findOne().orElse(null)
        );
    }
    public List<Product> getAllProducts() {
        Jdbi jdbi = DBConnection.getConnetion();
        String sql = "select * from products";
        List<Product> list = jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(Product.class).list());
        return list;
    }

    public Product getProductByName(String name) {
        Jdbi j = DBConnection.getConnetion();
        String sql = "select * from products where name = :name";
        return j.withHandle(h->
                h.createQuery(sql).bind("name",name)
                        .mapToBean(Product.class)
                        .findOne().orElse(null)
        );
    }
    
    public int getNumberPageProductByCategory(int idCategory, int pageSize) {
        String categoryQuery = "";
        if(idCategory != 0){
            categoryQuery = " where idCategory = " + idCategory;
        }
        String query = "select count(*) from products "+categoryQuery;
        int size =  jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .mapTo(Integer.class).first();
        });
        return (size % pageSize == 0) ? size / pageSize : size / pageSize + 1;
    }

    public List<Product> getProductsByCategoryBySort(int idCategory, int pageNumber, int pageSize, int options) {
        String sortBy = "";
        String sortOrder = "";
        String groupBy = "";
        String join = "";
        String sum = "";
        String categoryQuery = "";
        if (idCategory != 0) {
            categoryQuery = " p.idCategory = " + idCategory + " AND ";
        }

        switch (options) {
            case 1:
                sortBy = " p.addedDate ";
                sortOrder = " DESC ";
                break;
            case 2:
                sortBy = " pr.lastPrice ";
                sortOrder = " DESC ";
                break;
            case 3:
                sortBy = " pr.lastPrice ";
                sortOrder = " ASC ";
                break;
            case 4:
                sortBy = " totalProduct ";
                sortOrder = " DESC ";
                join = """
            LEFT JOIN styles s ON s.idProduct = p.id
            LEFT JOIN order_details od ON od.idStyle = s.id
            """;
                groupBy = """
            GROUP BY p.id, p.name, p.quantity, p.addedDate, p.description, 
                     p.area, p.selling, p.img, c.id, c.name, 
                     t.id, t.specifications, t.manufactureDate, 
                     pr.id, pr.price, pr.discountPercent, pr.lastPrice
            """;
                sum = ", SUM(od.quantity) AS totalProduct"; // tổng số lượng đã bán
                break;
            case 5:
                sortBy = " pr.discountPercent ";
                sortOrder = " DESC ";
                break;
            default:
                sortBy = " p.id ";
                sortOrder = " ASC "; // mặc định sắp xếp theo id
                break;
        }

        String query = """
    SELECT 
        p.id AS idProduct,
        p.name AS nameProduct,
        p.quantity,
        p.addedDate,
        p.description,
        p.area,
        p.selling,
        p.img,
        c.id AS idCategory,
        c.name AS categoryName,
        t.id AS idTechnicalInfo,
        t.specifications,
        t.manufactureDate,
        pr.id AS idPrice,
        pr.price,
        pr.discountPercent,
        pr.lastPrice
        """ + sum + """
     FROM products p
    JOIN categories c ON p.idCategory = c.id
    JOIN technical_information t ON p.id = t.id
    JOIN prices pr ON p.idPrice = pr.id
    """ + join + """
    WHERE """ + categoryQuery + """
     p.quantity > 0 AND p.selling > 0
    """ + groupBy + """
    ORDER BY """ + sortBy + " " + sortOrder + """
    LIMIT ? OFFSET ?;
    """;

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .bind(0, pageSize)
                .bind(1, (pageNumber - 1) * pageSize)
                .map((rs, ctx) -> {
                    // Product
                    Product product = new Product();
                    product.setId(rs.getInt("idProduct"));
                    product.setName(rs.getString("nameProduct"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    product.setDescription(rs.getString("description"));
                    product.setHeight(rs.getDouble("height")); // Thêm trường height
                    product.setWeight(rs.getDouble("weight")); // Thêm trường weight
                    product.setWidth(rs.getDouble("width"));   // Thêm trường width
                    product.setSelling(rs.getInt("selling"));
                    product.setImage(rs.getString("img"));

                    // Category
                    Category category = new Category();
                    category.setId(rs.getInt("idCategory"));
                    category.setName(rs.getString("categoryName"));
                    product.setCategory(category);

                    // Technical Information
                    TechnicalInfo technicalInfo = new TechnicalInfo();
                    technicalInfo.setId(rs.getInt("idTechnicalInfo"));
                    technicalInfo.setSpecification(rs.getString("specifications"));
                    technicalInfo.setManufactureDate(rs.getDate("manufactureDate").toLocalDate());
                    product.setTechnicalInfo(technicalInfo);

                    // Price
                    Price price = new Price();
                    price.setId(rs.getInt("idPrice"));
                    price.setPrice(rs.getDouble("price"));
                    price.setDiscountPercent(rs.getDouble("discountPercent"));
                    price.setLastPrice(rs.getDouble("lastPrice"));
                    product.setPrice(price);

                    return product;
                }).list());
    }
    public List<Product> getProductsBySearch(int idCategory, int pageNumber, int pageSize, int options,String inputName) {
        String input = "%"+inputName+"%";
        String sortBy = "";
        String sortOrder = "";
        String groupBy = "";
        String join = "";
        String sum = "";
        String categoryQuery = "";
        if (idCategory != 0) {
            categoryQuery = " p.idCategory = " + idCategory + " AND ";
        }

        switch (options) {
            case 1:
                sortBy = " p.addedDate ";
                sortOrder = " DESC ";
                break;
            case 2:
                sortBy = " pr.lastPrice ";
                sortOrder = " DESC ";
                break;
            case 3:
                sortBy = " pr.lastPrice ";
                sortOrder = " ASC ";
                break;
            case 4:
                sortBy = " totalProduct ";
                sortOrder = " DESC ";
                join = """
            LEFT JOIN styles s ON s.idProduct = p.id
            LEFT JOIN order_details od ON od.idStyle = s.id
            """;
                groupBy = """
            GROUP BY p.id, p.name, p.quantity, p.addedDate, p.description, 
                     p.area, p.selling, p.img, c.id, c.name, 
                     t.id, t.specifications, t.manufactureDate, 
                     pr.id, pr.price, pr.discountPercent, pr.lastPrice
            """;
                sum = ", SUM(od.quantity) AS totalProduct"; // tổng số lượng đã bán
                break;
            case 5:
                sortBy = " pr.discountPercent ";
                sortOrder = " DESC ";
                break;
            default:
                sortBy = " p.id ";
                sortOrder = " ASC "; // mặc định sắp xếp theo id
                break;
        }

        String query = """
    SELECT 
        p.id AS idProduct,
        p.name AS nameProduct,
        p.quantity,
        p.addedDate,
        p.description,
        p.height, p.weight, p.width,
        p.selling,
        p.img,
        c.id AS idCategory,
        c.name AS categoryName,
        t.id AS idTechnicalInfo,
        t.specifications,
        t.manufactureDate,
        pr.id AS idPrice,
        pr.price,
        pr.discountPercent,
        pr.lastPrice
        """ + sum + """
     FROM products p
    JOIN categories c ON p.idCategory = c.id
    JOIN technical_information t ON p.id = t.id
    JOIN prices pr ON p.idPrice = pr.id
    """ + join + """
    WHERE p.name LIKE ? AND """  + categoryQuery +"""
     p.quantity > 0 AND p.selling > 0
    """ + groupBy + """
    ORDER BY """ + sortBy + " " + sortOrder + """
    LIMIT ? OFFSET ?;
    """;

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .bind(0,input)
                .bind(1, pageSize)
                .bind(2, (pageNumber - 1) * pageSize)
                .map((rs, ctx) -> {
                    // Product
                    Product product = new Product();
                    product.setId(rs.getInt("idProduct"));
                    product.setName(rs.getString("nameProduct"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    product.setDescription(rs.getString("description"));
                    product.setHeight(rs.getDouble("height")); // Thêm trường height
                    product.setWeight(rs.getDouble("weight")); // Thêm trường weight
                    product.setWidth(rs.getDouble("width"));   // Thêm trường width
                    product.setSelling(rs.getInt("selling"));
                    product.setImage(rs.getString("img"));

                    // Category
                    Category category = new Category();
                    category.setId(rs.getInt("idCategory"));
                    category.setName(rs.getString("categoryName"));
                    product.setCategory(category);

                    // Technical Information
                    TechnicalInfo technicalInfo = new TechnicalInfo();
                    technicalInfo.setId(rs.getInt("idTechnicalInfo"));
                    technicalInfo.setSpecification(rs.getString("specifications"));
                    technicalInfo.setManufactureDate(rs.getDate("manufactureDate").toLocalDate());
                    product.setTechnicalInfo(technicalInfo);

                    // Price
                    Price price = new Price();
                    price.setId(rs.getInt("idPrice"));
                    price.setPrice(rs.getDouble("price"));
                    price.setDiscountPercent(rs.getDouble("discountPercent"));
                    price.setLastPrice(rs.getDouble("lastPrice"));
                    product.setPrice(price);

                    return product;
                }).list());
    }
    public List<Product> getProductsById(int idCategory, int pageNumber, int pageSize, int options, int inputId) {
        String sortBy = "";
        String sortOrder = "";
        String groupBy = "";
        String join = "";
        String sum = "";
        String categoryQuery = "";

        if (idCategory != 0) {
            categoryQuery = "AND p.idCategory = :idCategory ";
        }

        // Xử lý các tùy chọn sắp xếp
        switch (options) {
            case 1:
                sortBy = " p.addedDate ";
                sortOrder = " DESC ";
                break;
            case 2:
                sortBy = " pr.lastPrice ";
                sortOrder = " DESC ";
                break;
            case 3:
                sortBy = " pr.lastPrice ";
                sortOrder = " ASC ";
                break;
            case 4:
                sortBy = " totalProduct ";
                sortOrder = " DESC ";
                join = """
                LEFT JOIN styles s ON s.idProduct = p.id
                LEFT JOIN order_details od ON od.idStyle = s.id
                """;
                groupBy = """
                GROUP BY p.id, p.name, p.quantity, p.addedDate, p.description, 
                         p.height, p.weight, p.width, p.selling, p.img, c.id, c.name, 
                         t.id, t.specifications, t.manufactureDate, 
                         pr.id, pr.price, pr.discountPercent, pr.lastPrice
                """;
                sum = ", SUM(od.quantity) AS totalProduct"; // Tổng số lượng đã bán
                break;
            case 5:
                sortBy = " pr.discountPercent ";
                sortOrder = " DESC ";
                break;
            default:
                sortBy = " p.id ";
                sortOrder = " ASC "; // Mặc định sắp xếp theo ID
                break;
        }

        String query = """
        SELECT 
            p.id AS idProduct,
            p.name AS nameProduct,
            p.quantity,
            p.addedDate,
            p.description,
            p.height, p.weight, p.width,
            p.selling,
            p.img,
            c.id AS idCategory,
            c.name AS categoryName,
            t.id AS idTechnicalInfo,
            t.specifications,
            t.manufactureDate,
            pr.id AS idPrice,
            pr.price,
            pr.discountPercent,
            pr.lastPrice
            """ + sum + """
        FROM products p
        JOIN categories c ON p.idCategory = c.id
        JOIN technical_information t ON p.id = t.id
        JOIN prices pr ON p.idPrice = pr.id
        """ + join + """
        WHERE p.id = :inputId""" + categoryQuery + """
        """ + groupBy + """
         \n ORDER BY """ + sortBy + " " + sortOrder + """
        LIMIT :pageSize OFFSET :offset;
    """;

        // Thực thi truy vấn với các tham số đầu vào
        return jdbi.withHandle(handle -> handle.createQuery(query)
                .bind("inputId", inputId)  // Tìm theo ID
                .bind("pageSize", pageSize)
                .bind("offset", (pageNumber - 1) * pageSize)
                .bind("idCategory", idCategory)  // Bind category nếu có
                .map((rs, ctx) -> {
                    // Xử lý kết quả trả về và ánh xạ vào đối tượng Product
                    Product product = new Product();
                    product.setId(rs.getInt("idProduct"));
                    product.setName(rs.getString("nameProduct"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    product.setDescription(rs.getString("description"));
                    product.setHeight(rs.getDouble("height")); // Thêm trường height
                    product.setWeight(rs.getDouble("weight")); // Thêm trường weight
                    product.setWidth(rs.getDouble("width"));   // Thêm trường width
                    product.setSelling(rs.getInt("selling"));
                    product.setImage(rs.getString("img"));

                    // Category
                    Category category = new Category();
                    category.setId(rs.getInt("idCategory"));
                    category.setName(rs.getString("categoryName"));
                    product.setCategory(category);

                    // Technical Information
                    TechnicalInfo technicalInfo = new TechnicalInfo();
                    technicalInfo.setId(rs.getInt("idTechnicalInfo"));
                    technicalInfo.setSpecification(rs.getString("specifications"));
                    technicalInfo.setManufactureDate(rs.getDate("manufactureDate").toLocalDate());
                    product.setTechnicalInfo(technicalInfo);

                    // Price
                    Price price = new Price();
                    price.setId(rs.getInt("idPrice"));
                    price.setPrice(rs.getDouble("price"));
                    price.setDiscountPercent(rs.getDouble("discountPercent"));
                    price.setLastPrice(rs.getDouble("lastPrice"));
                    product.setPrice(price);

                    return product;
                }).list());
    }


    public static void main(String[] args) {
        ProductDao productDao = new ProductDao();
        System.out.println(productDao.getProductsById(0, 1, 20, 0,1));
    }

    public int getTotalProductCount() {
        String sql = "SELECT COUNT(*) FROM products";
        return jdbi.withHandle(handle -> handle.createQuery(sql).mapTo(Integer.class).one());
    }
    public List<Product> getProductByCategory(String name) {
        Jdbi jdbi = DBConnection.getConnetion();
        String sql = """
       SELECT
           p.id, p.name, p.quantity, p.addedDate, p.description,p.height, p.weight, p.width, p.selling, p.img,
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
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryName", name)
                        .map((rs, ctx) -> {

                            Category category = new Category();
                            category.setId(rs.getInt("category_id"));
                            category.setName(rs.getString("category_name"));

                            Product product = new Product();
                            product.setId(rs.getInt("id"));
                            product.setName(rs.getString("name"));
                            product.setQuantity(rs.getInt("quantity"));
                            product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                            product.setDescription(rs.getString("description"));
                            product.setHeight(rs.getDouble("height")); // Thêm trường height
                            product.setWeight(rs.getDouble("weight")); // Thêm trường weight
                            product.setWidth(rs.getDouble("width"));   // Thêm trường width
                            product.setSelling(rs.getInt("selling"));
                            product.setImage(rs.getString("img"));
                            product.setCategory(category); // Gắn Category vào Product

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
    public int updateProduct(Product product) {
        // Cập nhật thông tin sản phẩm
        String updateProductQuery = """
        UPDATE products 
        SET name = :name, quantity = :quantity, description = :description
        WHERE id = :idProduct;
    """;
        // Cập nhật thông tin kỹ thuật
        String updateTechnicalInfoQuery = """
        UPDATE technical_information 
        SET specifications = :specifications, manufactureDate = :manufactureDate 
        WHERE id = :idTechnicalInfo;
    """;

        // Cập nhật thông tin giá
        String updatePriceQuery = """
        UPDATE prices 
        SET price = :price, discountPercent = :discountPercent
        WHERE id = :idPrice;
    """;

        // Thực thi các câu lệnh SQL
        return jdbi.withHandle(handle -> {
            handle.createUpdate(updateProductQuery)
                    .bind("idProduct", product.getId())
                    .bind("name", product.getName())
                    .bind("quantity", product.getQuantity())
                    .bind("description", product.getDescription())
                    .execute();

            handle.createUpdate(updateTechnicalInfoQuery)
                    .bind("idTechnicalInfo", product.getTechnicalInfo().getId())
                    .bind("specifications", product.getTechnicalInfo().getSpecification())
                    .bind("manufactureDate", product.getTechnicalInfo().getManufactureDate())
                    .execute();

            handle.createUpdate(updatePriceQuery)
                    .bind("idPrice", product.getPrice().getId())
                    .bind("price", product.getPrice().getPrice())
                    .bind("discountPercent", product.getPrice().getDiscountPercent())
                    .execute();

            return 1; // Trả về 1 khi thành công
        });
    }

    public List<Product> getProductByCategory(String name , int psize, int pageNumber) {


        String sql = """
       SELECT
           p.id, p.name, p.quantity, p.addedDate, p.description,p.height, p.weight, p.width, p.selling, p.img,
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
       LIMIT :psize OFFSET :offset;
    """;

        int offset = psize * (pageNumber - 1); // Tính offset dựa trên trang hiện tại và số lượng sản phẩm mỗi trang

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryName", name)
                        .bind("psize", psize)
                        .bind("offset", offset)
                        .map((rs, ctx) -> {

                            Category category = new Category();
                            category.setId(rs.getInt("category_id"));
                            category.setName(rs.getString("category_name"));

                            Product product = new Product();
                            product.setId(rs.getInt("id"));
                            product.setName(rs.getString("name"));
                            product.setQuantity(rs.getInt("quantity"));
                            product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                            product.setHeight(rs.getDouble("height")); // Thêm trường height
                            product.setWeight(rs.getDouble("weight")); // Thêm trường weight
                            product.setWidth(rs.getDouble("width"));   // Thêm trường width
                            product.setSelling(rs.getInt("selling"));
                            product.setImage(rs.getString("img"));
                            product.setCategory(category); // Gắn Category vào Product

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
    public void stopBuyProduct(int id) {
        String sql = "UPDATE products SET selling = 0 WHERE id = :id";
        jdbi.withHandle(handle -> handle.createUpdate(sql).bind("id", id).execute());
    }
    public void startBuyProduct(int id) {
        String sql = "UPDATE products SET selling = 1 WHERE id = :id";
        jdbi.withHandle(handle -> handle.createUpdate(sql).bind("id", id).execute());
    }

    public List<Product> getProductsByCategoryBySortButton(int idCategory, int pageNumber, int pageSize, int option, Double minPrice, Double maxPrice) {
        String sortBy = "";
        String sortOrder = "";
        String groupBy = "";
        String join = "";
        String sum = "";

        switch (option) {
            case 1:
                sortBy = "p.addedDate";
                sortOrder = "DESC";
                break;
            case 2:
                sortBy = "pr.lastPrice";
                sortOrder = "DESC";
                break;
            case 3:
                sortBy = "pr.lastPrice";
                sortOrder = "ASC";
                break;
            case 4:
                sortBy = "totalProduct";
                sortOrder = "DESC";
                join = "LEFT JOIN styles s ON s.idProduct = p.id " +
                        "LEFT JOIN order_details od ON od.idStyle = s.id ";
                groupBy = "GROUP BY p.id, p.name, p.quantity, p.addedDate, p.description, " +
                        "p.area, p.selling, p.img, c.id, c.name, " +
                        "t.id, t.specifications, t.manufactureDate, " +
                        "pr.id, pr.price, pr.discountPercent, pr.lastPrice ";
                sum = ", SUM(od.quantity) AS totalProduct ";
                break;
            case 5:
                sortBy = "pr.discountPercent";
                sortOrder = "DESC";
                break;
            default:
                sortBy = "p.id";
                sortOrder = "ASC";
                break;
        }

        StringBuilder query = new StringBuilder();
        query.append("SELECT p.id AS idProduct, ")
                .append("p.name AS nameProduct, ")
                .append("p.quantity, ")
                .append("p.addedDate, ")
                .append("p.description, ")
                .append("p.area, ")
                .append("p.selling, ")
                .append("p.img, ")
                .append("c.id AS idCategory, ")
                .append("c.name AS categoryName, ")
                .append("t.id AS idTechnicalInfo, ")
                .append("t.specifications, ")
                .append("t.manufactureDate, ")
                .append("pr.id AS idPrice, ")
                .append("pr.price, ")
                .append("pr.discountPercent, ")
                .append("pr.lastPrice ")
                .append(sum)
                .append("FROM products p ")
                .append("JOIN categories c ON p.idCategory = c.id ")
                .append("JOIN prices pr ON p.idPrice = pr.id ")
                .append("JOIN technical_information t ON p.idTechnical = t.id ")
                .append(join)
                .append("WHERE p.idCategory = :idCategory ")
                .append("AND p.quantity > 0 ")
                .append("AND p.selling > 0 ");

        if (minPrice != null) {
            query.append("AND pr.lastPrice >= :minPrice ");
        }
        if (maxPrice != null) {
            query.append("AND pr.lastPrice <= :maxPrice ");
        }

        if (option == 4) { // Best-selling
            query.append(groupBy);
        }

        query.append("ORDER BY ").append(sortBy).append(" ").append(sortOrder).append(" ");
        query.append("LIMIT :pageSize OFFSET :offset;");

        // Logging truy vấn và các tham số
        System.out.println("Executing SQL Query: " + query.toString());
        System.out.println("Parameters - idCategory: " + idCategory + ", pageSize: " + pageSize + ", offset: " + ((pageNumber - 1) * pageSize) + ", minPrice: " + minPrice + ", maxPrice: " + maxPrice);

        return jdbi.withHandle(handle -> {
            var q = handle.createQuery(query.toString())
                    .bind("idCategory", idCategory)
                    .bind("pageSize", pageSize)
                    .bind("offset", (pageNumber - 1) * pageSize);

            if (minPrice != null) {
                q.bind("minPrice", minPrice);
            }
            if (maxPrice != null) {
                q.bind("maxPrice", maxPrice);
            }
            return q.map((rs, ctx) -> {
                Product product = new Product();
                product.setId(rs.getInt("idProduct"));
                product.setName(rs.getString("nameProduct"));
                product.setQuantity(rs.getInt("quantity"));
                product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                product.setDescription(rs.getString("description"));
                product.setHeight(rs.getDouble("height")); // Thêm trường height
                product.setWeight(rs.getDouble("weight")); // Thêm trường weight
                product.setWidth(rs.getDouble("width"));   // Thêm trường width
                product.setSelling(rs.getInt("selling"));
                product.setImage(rs.getString("img"));

                Category category = new Category();
                category.setId(rs.getInt("idCategory"));
                category.setName(rs.getString("categoryName"));
                product.setCategory(category);

                TechnicalInfo technicalInfo = new TechnicalInfo();
                technicalInfo.setId(rs.getInt("idTechnicalInfo"));
                technicalInfo.setSpecification(rs.getString("specifications"));
                technicalInfo.setManufactureDate(rs.getDate("manufactureDate").toLocalDate());
                product.setTechnicalInfo(technicalInfo);

                Price price = new Price();
                price.setId(rs.getInt("idPrice"));
                price.setPrice(rs.getDouble("price"));
                price.setDiscountPercent(rs.getDouble("discountPercent"));
                price.setLastPrice(rs.getDouble("lastPrice"));
                product.setPrice(price);

                return product;
            }).list();
        });
    }

    public int getNumberPageProductByCategoryButton(int idCategory, int pageSize, Double minPrice, Double maxPrice) {
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM products p ");
        query.append("JOIN prices pr ON p.idPrice = pr.id ");
        query.append("WHERE p.idCategory = :idCategory AND p.quantity > 0 AND p.selling > 0 ");

        if (minPrice != null) {
            query.append("AND pr.lastPrice >= :minPrice ");
        }
        if (maxPrice != null) {
            query.append("AND pr.lastPrice <= :maxPrice ");
        }

        Integer count = jdbi.withHandle(handle -> {
            var q = handle.createQuery(query.toString())
                    .bind("idCategory", idCategory);
            if (minPrice != null) {
                q.bind("minPrice", minPrice);
            }
            if (maxPrice != null) {
                q.bind("maxPrice", maxPrice);
            }
            return q.mapTo(Integer.class).one();
        });

        return (count % pageSize == 0) ? count / pageSize : count / pageSize + 1;
    }

    public int getNumberPageProductByCategoryZipStar(int idCategory, int pageSize, Double minPrice, Double maxPrice) {
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM products p ");
        query.append("JOIN prices pr ON p.idPrice = pr.id ");
        query.append("WHERE p.idCategory = :idCategory AND p.quantity > 0 AND p.selling > 0 ");

        if (minPrice != null) {
            query.append("AND pr.lastPrice >= :minPrice ");
        }
        if (maxPrice != null) {
            query.append("AND pr.lastPrice <= :maxPrice ");
        }

        Integer count = jdbi.withHandle(handle -> {
            var q = handle.createQuery(query.toString())
                    .bind("idCategory", idCategory);
            if (minPrice != null) {
                q.bind("minPrice", minPrice);
            }
            if (maxPrice != null) {
                q.bind("maxPrice", maxPrice);
            }
            return q.mapTo(Integer.class).one();
        });

        return (count % pageSize == 0) ? count / pageSize : count / pageSize + 1;
    }


    public int addProduct(Product product) {
        return jdbi.inTransaction(handle -> {
            // Thêm TechnicalInfo và lấy ID
            int technicalId = handle.createUpdate(
                            "INSERT INTO technical_information (specifications, manufactureDate) VALUES (:specifications, :manufactureDate)")
                    .bind("specifications", product.getTechnicalInfo().getSpecification())
                    .bind("manufactureDate", java.sql.Date.valueOf(product.getTechnicalInfo().getManufactureDate()))
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(int.class)
                    .one();

            // Gán ID đã tạo cho TechnicalInfo trong product
            product.getTechnicalInfo().setId(technicalId);

            // Thêm Price và lấy ID
            int priceId = handle.createUpdate(
                            "INSERT INTO prices (price, discountPercent) VALUES (:price, :discountPercent)")
                    .bind("price", product.getPrice().getPrice())
                    .bind("discountPercent", product.getPrice().getDiscountPercent())
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(int.class)
                    .one();

            // Gán ID đã tạo cho Price trong product
            product.getPrice().setId(priceId);

            // Thêm Product và lấy ID
            String query = """
            INSERT INTO products (name, quantity, idCategory, addedDate, description, area, selling, img, idTechnical, idPrice)
            VALUES (:name, :quantity, :idCategory, :addedDate, :description, :area, :selling, :img, :idTechnical, :idPrice)
            """;
            return handle.createUpdate(query)
                    .bind("name", product.getName())
                    .bind("quantity", product.getQuantity())
                    .bind("idCategory", product.getCategory().getId())
                    .bind("addedDate", java.sql.Date.valueOf(product.getDateAdded()))
                    .bind("description", product.getDescription())
                    .bind("selling", product.getSelling())
                    .bind("img", product.getImage())
                    .bind("idTechnical", technicalId)
                    .bind("idPrice", priceId)
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(int.class)
                    .one();
        });
    }


    public List<Product> getAllProductForAdmin(int idCategory, int pageNumber, int pageSize, int options) {
        String sortBy = "";
        String sortOrder = "";
        String groupBy = "";
        String join = "";
        String sum = "";
        String categoryQuery = "";
        if (idCategory != 0) {
            categoryQuery = " p.idCategory = " + idCategory + " AND ";
        }

        switch (options) {
            case 1:
                sortBy = " p.addedDate ";
                sortOrder = " DESC ";
                break;
            case 2:
                sortBy = " pr.lastPrice ";
                sortOrder = " DESC ";
                break;
            case 3:
                sortBy = " pr.lastPrice ";
                sortOrder = " ASC ";
                break;
            case 4:
                sortBy = " totalProduct ";
                sortOrder = " DESC ";
                join = """
            LEFT JOIN styles s ON s.idProduct = p.id
            LEFT JOIN order_details od ON od.idStyle = s.id
            """;
                groupBy = """
            GROUP BY p.id, p.name, p.quantity, p.addedDate, p.description, 
                     p.area, p.selling, p.img, c.id, c.name, 
                     t.id, t.specifications, t.manufactureDate, 
                     pr.id, pr.price, pr.discountPercent, pr.lastPrice
            """;
                sum = ", SUM(od.quantity) AS totalProduct"; // tổng số lượng đã bán
                break;
            case 5:
                sortBy = " pr.discountPercent ";
                sortOrder = " DESC ";
                break;
            default:
                sortBy = " p.id ";
                sortOrder = " ASC "; // mặc định sắp xếp theo id
                break;
        }

        String query = """
    SELECT 
        p.id AS idProduct,
        p.name AS nameProduct,
        p.quantity,
        p.addedDate,
        p.description,
        p.area,
        p.selling,
        p.img,
        c.id AS idCategory,
        c.name AS categoryName,
        t.id AS idTechnicalInfo,
        t.specifications,
        t.manufactureDate,
        pr.id AS idPrice,
        pr.price,
        pr.discountPercent,
        pr.lastPrice
        """ + sum + """
     FROM products p
    JOIN categories c ON p.idCategory = c.id
    JOIN technical_information t ON p.id = t.id
    JOIN prices pr ON p.idPrice = pr.id
    """ + join + """
    """ + groupBy + """
    ORDER BY """ + sortBy + " " + sortOrder + """
    LIMIT ? OFFSET ?;
    """;

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .bind(0, pageSize)
                .bind(1, (pageNumber - 1) * pageSize)
                .map((rs, ctx) -> {
                    // Product
                    Product product = new Product();
                    product.setId(rs.getInt("idProduct"));
                    product.setName(rs.getString("nameProduct"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    product.setDescription(rs.getString("description"));
                    product.setSelling(rs.getInt("selling"));
                    product.setImage(rs.getString("img"));

                    // Category
                    Category category = new Category();
                    category.setId(rs.getInt("idCategory"));
                    category.setName(rs.getString("categoryName"));
                    product.setCategory(category);

                    // Technical Information
                    TechnicalInfo technicalInfo = new TechnicalInfo();
                    technicalInfo.setId(rs.getInt("idTechnicalInfo"));
                    technicalInfo.setSpecification(rs.getString("specifications"));
                    technicalInfo.setManufactureDate(rs.getDate("manufactureDate").toLocalDate());
                    product.setTechnicalInfo(technicalInfo);

                    // Price
                    Price price = new Price();
                    price.setId(rs.getInt("idPrice"));
                    price.setPrice(rs.getDouble("price"));
                    price.setDiscountPercent(rs.getDouble("discountPercent"));
                    price.setLastPrice(rs.getDouble("lastPrice"));
                    product.setPrice(price);

                    return product;
                }).list());
    }



}
