package models;

public class Style extends Product {
    private int id;
    private Product product;
    private String name;
    private String image;
    private int quantity;
    private Price price;

    @Override
    public int getId() {
        return id;
    }

    @Override
    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String getImage() {
        return image;
    }

    @Override
    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public int getQuantity() {
        return quantity;
    }

    @Override
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Price getPrice() {
        return price;
    }

    public void setPrice(Price price) {
        this.price = price;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Style(int id, Product product, String name, String image, int quantity, Price price) {
        this.id = id;
        this.product = product;
        this.name = name;
        this.image = image;
        this.quantity = quantity;
        this.price = price;
    }
}
