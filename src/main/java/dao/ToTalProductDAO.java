package dao;

import connection.DBConnection;
import models.Category;
import models.Price;
import models.Product;
import models.TechnicalInfo;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class ToTalProductDAO {
    private Jdbi jdbi;
    public ToTalProductDAO() {
        jdbi = DBConnection.getConnetion();
    }
    public List<Product> getProductsByIds(List<Integer> ids) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE id IN (<ids>)")
                        .bindList("ids", ids)
                        .map((rs, ctx) -> {
                            Product product = new Product();
                            product.setId(rs.getInt("id"));
                            product.setName(rs.getString("name"));
                            product.setQuantity(rs.getInt("quantity"));
                            product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                            product.setDescription(rs.getString("description"));
                            product.setHeight(rs.getDouble("height"));
                            product.setWeight(rs.getDouble("weight"));
                            product.setWidth(rs.getDouble("width"));
                            product.setSelling(rs.getInt("selling"));
                            product.setImage(rs.getString("img"));
                            product.setTotalProduct(rs.getInt("quantity")); // you can calculate differently if needed
                            CategoryDao categoryDAO = new CategoryDao();
                            TechnicalDAO technicalDAO = new TechnicalDAO();
                            PriceDAO priceDAO = new PriceDAO();

                            product.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                            product.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                            product.setPrice(priceDAO.findById(rs.getInt("idPrice")));

                            return product;
                        })
                        .list()
        );
    }
    public List<Product> getProductsBestSellerByCategory(String selection, int currentPage, int nuPerPage) {
        int offset = (currentPage - 1) * nuPerPage;

        return jdbi.withHandle(handle -> {
            String sql = "SELECT p.*, COUNT(od.idStyle) AS order_count " +
                    "FROM orders o " +
                    "JOIN order_details od ON o.id = od.idOrder " +
                    "JOIN styles s ON od.idStyle = s.id " +
                    "JOIN products p ON s.idProduct = p.id " +
                    "JOIN categories c ON p.idCategory = c.id " +
                    "WHERE o.statusOrder = 'Đã thanh toán' " +
                    "AND c.name = :selection " +
                    "GROUP BY p.id " +
                    "ORDER BY order_count DESC " +
                    "LIMIT :limit OFFSET :offset";

            return handle.createQuery(sql)
                    .bind("selection", selection)
                    .bind("limit", nuPerPage)
                    .bind("offset", offset)
                    .map((rs, ctx) -> {
                        Product product = new Product();
                        product.setId(rs.getInt("id"));
                        product.setName(rs.getString("name"));
                        product.setQuantity(rs.getInt("quantity"));
                        product.setDateAdded(rs.getDate("addedDate").toLocalDate());
                        product.setDescription(rs.getString("description"));
                        product.setHeight(rs.getDouble("height"));
                        product.setWeight(rs.getDouble("weight"));
                        product.setWidth(rs.getDouble("width"));
                        product.setSelling(rs.getInt("selling"));
                        product.setImage(rs.getString("img"));
                        product.setTotalProduct(rs.getInt("quantity")); // you can calculate differently if needed
                        CategoryDao categoryDAO = new CategoryDao();
                        TechnicalDAO technicalDAO = new TechnicalDAO();
                        PriceDAO priceDAO = new PriceDAO();

                        product.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                        product.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                        product.setPrice(priceDAO.findById(rs.getInt("idPrice")));

                        return product;
                    })
                    .list();
        });
    }
    public List<Product> getAllProducts(int currentPage, int nuPerPage) {
        int offset = (currentPage - 1) * nuPerPage;

        return jdbi.withHandle(handle -> handle.createQuery(
                        "SELECT * FROM products LIMIT :limit OFFSET :offset")
                .bind("limit", nuPerPage)
                .bind("offset", offset)
                .map((rs, ctx) -> {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    p.setDescription(rs.getString("description"));
                    p.setHeight(rs.getDouble("height"));
                    p.setWeight(rs.getDouble("weight"));
                    p.setWidth(rs.getDouble("width"));
                    p.setSelling(rs.getInt("selling"));
                    p.setImage(rs.getString("img"));
                    p.setTotalProduct(rs.getInt("quantity")); // bạn có thể tính khác nếu cần
                    CategoryDao categoryDAO = new CategoryDao();
                    TechnicalDAO technicalDAO = new TechnicalDAO();
                    PriceDAO priceDAO = new PriceDAO();

                    p.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                    p.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                    p.setPrice(priceDAO.findById(rs.getInt("idPrice")));
                    return p;
                })
                .list());
    }
    public List<Product> getProductLatest(int currentPage, int nuPerPage) {
        int offset = (currentPage - 1) * nuPerPage;

        return jdbi.withHandle(handle -> handle.createQuery(
                        "SELECT p.* " +
                                "FROM products p " +
                                "JOIN technical_information t ON p.idTechnical = t.id " +
                                "ORDER BY t.releaseDay DESC " +
                                "LIMIT :limit OFFSET :offset")
                .bind("limit", nuPerPage)
                .bind("offset", offset)
                .map((rs, ctx) -> {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    p.setDescription(rs.getString("description"));
                    p.setHeight(rs.getDouble("height"));
                    p.setWeight(rs.getDouble("weight"));
                    p.setWidth(rs.getDouble("width"));
                    p.setSelling(rs.getInt("selling"));
                    p.setImage(rs.getString("img"));
                    p.setTotalProduct(rs.getInt("quantity"));

                    // Lấy thông tin từ các bảng liên quan
                    CategoryDao categoryDAO = new CategoryDao();
                    TechnicalDAO technicalDAO = new TechnicalDAO();
                    PriceDAO priceDAO = new PriceDAO();

                    p.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                    p.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                    p.setPrice(priceDAO.findById(rs.getInt("idPrice")));

                    return p;
                })
                .list());
    }
    public List<Product> getProductByPrice(int currentPage, int nuPerPage, String order) {
        int offset = (currentPage - 1) * nuPerPage;

        String sortOrder = "ASC";
        if ("decreasing".equalsIgnoreCase(order)) {
            sortOrder = "DESC";
        }

        String sql = "SELECT p.* " +
                "FROM products p " +
                "JOIN prices pr ON p.idPrice = pr.id " +
                "ORDER BY pr.lastPrice " + sortOrder + " " +
                "LIMIT :limit OFFSET :offset";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("limit", nuPerPage)
                .bind("offset", offset)
                .map((rs, ctx) -> {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    p.setDescription(rs.getString("description"));
                    p.setHeight(rs.getDouble("height"));
                    p.setWeight(rs.getDouble("weight"));
                    p.setWidth(rs.getDouble("width"));
                    p.setSelling(rs.getInt("selling"));
                    p.setImage(rs.getString("img"));
                    p.setTotalProduct(rs.getInt("quantity"));

                    // Gọi các DAO khác để lấy thông tin liên quan
                    CategoryDao categoryDAO = new CategoryDao();
                    TechnicalDAO technicalDAO = new TechnicalDAO();
                    PriceDAO priceDAO = new PriceDAO();

                    p.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                    p.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                    p.setPrice(priceDAO.findById(rs.getInt("idPrice")));

                    return p;
                })
                .list());
    }
    public List<Product> getProductBiggestDiscount(int currentPage, int nuPerPage) {
        int offset = (currentPage - 1) * nuPerPage;

        String sql = "SELECT p.* " +
                "FROM products p " +
                "JOIN prices pr ON p.idPrice = pr.id " +
                "ORDER BY pr.discountPercent DESC " +
                "LIMIT :limit OFFSET :offset";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("limit", nuPerPage)
                .bind("offset", offset)
                .map((rs, ctx) -> {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    p.setDescription(rs.getString("description"));
                    p.setHeight(rs.getDouble("height"));
                    p.setWeight(rs.getDouble("weight"));
                    p.setWidth(rs.getDouble("width"));
                    p.setSelling(rs.getInt("selling"));
                    p.setImage(rs.getString("img"));
                    p.setTotalProduct(rs.getInt("quantity"));

                    // Lấy các thông tin liên kết
                    CategoryDao categoryDAO = new CategoryDao();
                    TechnicalDAO technicalDAO = new TechnicalDAO();
                    PriceDAO priceDAO = new PriceDAO();

                    p.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                    p.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                    p.setPrice(priceDAO.findById(rs.getInt("idPrice")));

                    return p;
                })
                .list());
    }
    public List<Product> getProductByCategoryName(String selection, int currentPage, int nuPerPage) {
        int offset = (currentPage - 1) * nuPerPage;

        String sql = "SELECT p.* " +
                "FROM products p " +
                "JOIN categories c ON p.idCategory = c.id " +
                "WHERE c.name = :categoryName " +
                "LIMIT :limit OFFSET :offset";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("categoryName", selection)
                .bind("limit", nuPerPage)
                .bind("offset", offset)
                .map((rs, ctx) -> {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    p.setDescription(rs.getString("description"));
                    p.setHeight(rs.getDouble("height"));
                    p.setWeight(rs.getDouble("weight"));
                    p.setWidth(rs.getDouble("width"));
                    p.setSelling(rs.getInt("selling"));
                    p.setImage(rs.getString("img"));
                    p.setTotalProduct(rs.getInt("quantity"));

                    // Lấy dữ liệu liên kết
                    CategoryDao categoryDAO = new CategoryDao();
                    TechnicalDAO technicalDAO = new TechnicalDAO();
                    PriceDAO priceDAO = new PriceDAO();

                    p.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                    p.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                    p.setPrice(priceDAO.findById(rs.getInt("idPrice")));

                    return p;
                })
                .list());
    }
    public List<Product> getProductByCategoryNameWithOption(String selection, int currentPage, int nuPerPage, String option) {
        int offset = (currentPage - 1) * nuPerPage;

        String orderClause = "";
        switch (option) {
            case "latest":
                orderClause = "ORDER BY ti.releaseDay DESC";
                break;
            case "expensive":
                orderClause = "ORDER BY pr.lastPrice DESC";
                break;
            case "cheap":
                orderClause = "ORDER BY pr.lastPrice ASC";
                break;
            case "discount":
                orderClause = "ORDER BY pr.discountPercent DESC";
                break;
            default:
                orderClause = "";
                break;
        }

        String sql = "SELECT p.* " +
                "FROM products p " +
                "JOIN categories c ON p.idCategory = c.id " +
                "JOIN prices pr ON p.idPrice = pr.id " +
                "JOIN technical_information ti ON p.idTechnical = ti.id " +
                "WHERE c.name = :categoryName " +
                orderClause + " " +
                "LIMIT :limit OFFSET :offset";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("categoryName", selection)
                .bind("limit", nuPerPage)
                .bind("offset", offset)
                .map((rs, ctx) -> {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    p.setDescription(rs.getString("description"));
                    p.setHeight(rs.getDouble("height"));
                    p.setWeight(rs.getDouble("weight"));
                    p.setWidth(rs.getDouble("width"));
                    p.setSelling(rs.getInt("selling"));
                    p.setImage(rs.getString("img"));
                    p.setTotalProduct(rs.getInt("quantity"));

                    // Lấy dữ liệu liên kết
                    CategoryDao categoryDAO = new CategoryDao();
                    TechnicalDAO technicalDAO = new TechnicalDAO();
                    PriceDAO priceDAO = new PriceDAO();

                    p.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                    p.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                    p.setPrice(priceDAO.findById(rs.getInt("idPrice")));

                    return p;
                })
                .list());
    }
    public List<Product> getProductByCategoryAndPriceRange(String selection, int currentPage, int nuPerPage, String minPrice, String maxPrice) {
        int offset = (currentPage - 1) * nuPerPage;

        String sql = "SELECT p.* " +
                "FROM products p " +
                "JOIN categories c ON p.idCategory = c.id " +
                "JOIN prices pr ON p.idPrice = pr.id " +
                "WHERE c.name = :categoryName " +
                "AND pr.price BETWEEN :min AND :max " +
                "LIMIT :limit OFFSET :offset";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("categoryName", selection)
                .bind("min", Double.parseDouble(minPrice))
                .bind("max", Double.parseDouble(maxPrice))
                .bind("limit", nuPerPage)
                .bind("offset", offset)
                .map((rs, ctx) -> {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    p.setDescription(rs.getString("description"));
                    p.setHeight(rs.getDouble("height"));
                    p.setWeight(rs.getDouble("weight"));
                    p.setWidth(rs.getDouble("width"));
                    p.setSelling(rs.getInt("selling"));
                    p.setImage(rs.getString("img"));
                    p.setTotalProduct(rs.getInt("quantity"));

                    // Gán liên kết
                    CategoryDao categoryDAO = new CategoryDao();
                    TechnicalDAO technicalDAO = new TechnicalDAO();
                    PriceDAO priceDAO = new PriceDAO();

                    p.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                    p.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                    p.setPrice(priceDAO.findById(rs.getInt("idPrice")));

                    return p;
                })
                .list());
    }


    public List<Product> getAllProductByPriceRange(int currentPage, int nuPerPage, String minPrice, String maxPrice) {
        int offset = (currentPage - 1) * nuPerPage;

        String sql = "SELECT p.* " +
                "FROM products p " +
                "JOIN prices pr ON p.idPrice = pr.id " +
                "WHERE pr.price BETWEEN :min AND :max " +
                "LIMIT :limit OFFSET :offset";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("min", Double.parseDouble(minPrice))
                .bind("max", Double.parseDouble(maxPrice))
                .bind("limit", nuPerPage)
                .bind("offset", offset)
                .map((rs, ctx) -> {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    p.setDescription(rs.getString("description"));
                    p.setHeight(rs.getDouble("height"));
                    p.setWeight(rs.getDouble("weight"));
                    p.setWidth(rs.getDouble("width"));
                    p.setSelling(rs.getInt("selling"));
                    p.setImage(rs.getString("img"));
                    p.setTotalProduct(rs.getInt("quantity"));

                    // Gán các liên kết (category, technical, price)
                    CategoryDao categoryDAO = new CategoryDao();
                    TechnicalDAO technicalDAO = new TechnicalDAO();
                    PriceDAO priceDAO = new PriceDAO();

                    p.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                    p.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                    p.setPrice(priceDAO.findById(rs.getInt("idPrice")));

                    return p;
                })
                .list());
    }

    public static void main(String[] args) {
        ToTalProductDAO dao = new ToTalProductDAO();
        //System.out.println(dao.getAllProducts(1, 10));
        //System.out.println(dao.getProductLatest(1, 10));
        //System.out.println(dao.getProductByPrice(1,10,"ascending"));
        //System.out.println(dao.getProductByCategoryNameWithOption("Vải may mặc",1,10,"latest"));
        System.out.println(dao.getProductsBestSellerByCategory("Vải may mặc",1,4));
    }




    public int countProducts() {
        String sql = "SELECT COUNT(*) FROM products";

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public int countProductsByCategoryName(String selection) {
        String sql = "SELECT COUNT(*) " +
                "FROM products p " +
                "JOIN categories c ON p.idCategory = c.id " +
                "WHERE c.name = :categoryName";

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryName", selection)
                        .mapTo(Integer.class)
                        .one()
        );

    }
    public Product getProductById(int id) {
        return jdbi.withHandle(handle -> handle.createQuery(
                        "SELECT p.* " +
                                "FROM products p " +
                                "WHERE p.id = :id")
                .bind("id", id)
                .map((rs, ctx) -> {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    p.setDescription(rs.getString("description"));
                    p.setHeight(rs.getDouble("height"));
                    p.setWeight(rs.getDouble("weight"));
                    p.setWidth(rs.getDouble("width"));
                    p.setSelling(rs.getInt("selling"));
                    p.setImage(rs.getString("img"));
                    p.setTotalProduct(rs.getInt("quantity"));

                    // Gọi DAO để lấy dữ liệu liên quan
                    CategoryDao categoryDAO = new CategoryDao();
                    TechnicalDAO technicalDAO = new TechnicalDAO();
                    PriceDAO priceDAO = new PriceDAO();

                    p.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                    p.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                    p.setPrice(priceDAO.findById(rs.getInt("idPrice")));


                    return p;
                })
                .findOne() // Vì chỉ trả về 1 sản phẩm
                .orElse(null)); // Trả về null nếu không tìm thấy
    }
    public Product getProductByName(String name) {
        return jdbi.withHandle(handle -> handle.createQuery(
                        "SELECT p.* " +
                                "FROM products p " +
                                "WHERE p.name = :name")
                .bind("name", name)
                .map((rs, ctx) -> {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    p.setDescription(rs.getString("description"));
                    p.setHeight(rs.getDouble("height"));
                    p.setWeight(rs.getDouble("weight"));
                    p.setWidth(rs.getDouble("width"));
                    p.setSelling(rs.getInt("selling"));
                    p.setImage(rs.getString("img"));
                    p.setTotalProduct(rs.getInt("quantity"));

                    // Gọi DAO để lấy dữ liệu liên quan
                    CategoryDao categoryDAO = new CategoryDao();
                    TechnicalDAO technicalDAO = new TechnicalDAO();
                    PriceDAO priceDAO = new PriceDAO();

                    p.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                    p.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                    p.setPrice(priceDAO.findById(rs.getInt("idPrice")));

                    return p;
                })
                .findOne() // Vì chỉ trả về 1 sản phẩm
                .orElse(null)); // Trả về null nếu không tìm thấy
    }
    public List<Product> searchProductByName(String name) {
        return jdbi.withHandle(handle -> handle.createQuery(
                        "SELECT p.* " +
                                "FROM products p " +
                                "JOIN technical_information t ON p.idTechnical = t.id " +
                                "WHERE LOWER(p.name) LIKE LOWER(:name) " +
                                "LIMIT 12")
                .bind("name", "%" + name.trim() + "%")
                .map((rs, ctx) -> {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setDateAdded(rs.getDate("addedDate").toLocalDate());
                    p.setDescription(rs.getString("description"));
                    p.setHeight(rs.getDouble("height"));
                    p.setWeight(rs.getDouble("weight"));
                    p.setWidth(rs.getDouble("width"));
                    p.setSelling(rs.getInt("selling"));
                    p.setImage(rs.getString("img"));
                    p.setTotalProduct(rs.getInt("quantity"));

                    // Gọi DAO liên quan
                    CategoryDao categoryDAO = new CategoryDao();
                    TechnicalDAO technicalDAO = new TechnicalDAO();
                    PriceDAO priceDAO = new PriceDAO();

                    p.setCategory(categoryDAO.findById(rs.getInt("idCategory")));
                    p.setTechnicalInfo(technicalDAO.findById(rs.getInt("idTechnical")));
                    p.setPrice(priceDAO.findById(rs.getInt("idPrice")));

                    return p;
                }).list());
    }





    }
