package models;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Product implements Serializable {
    private int id;
    private String name;
    private int quantity;
    private LocalDate dateAdded;
    private String description;
    private double area;
    private int selling;
    private String image;
    private Category category;
    private TechnicalInfo technicalInfo;
    private Price price;
    private List<Style> styles = new ArrayList<>();
    //biến mới thêm
    private int totalProduct;

    public Product(int id) {
        this.id = id;
    }


    public int getId() {
        return id;
    }

    public LocalDate getDateAdded() {
        return dateAdded;
    }

    public List<Style> getStyles() {
        return styles;
    }

    public void setStyles(List<Style> styles) {
        this.styles = styles;
    }

    public void setDateAdded(LocalDate dateAdded) {
        this.dateAdded = dateAdded;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public int getSelling() {
        return selling;
    }

    public void setSelling(int selling) {
        this.selling = selling;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public TechnicalInfo getTechnicalInfo() {
        return technicalInfo;
    }

    public void setTechnicalInfo(TechnicalInfo technicalInfo) {
        this.technicalInfo = technicalInfo;
    }
    public Price getPrice() {
        return price;
    }
    public void setPrice(Price price) {
        this.price = price;
    }


    public Product(int id, String name, int quantity, LocalDate dateAdded, String description, double area, int selling, String image, Category category, TechnicalInfo technicalInfo, Price price) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.dateAdded = dateAdded;
        this.description = description;
        this.area = area;
        this.selling = selling;
        this.image = image;
        this.category = category;
        this.technicalInfo = technicalInfo;
        this.price = price;
        //Dòng mới thêm
        this.styles = new ArrayList<>(); // Khởi tạo danh sách trống
    }


    public Product() {

    }

    @Override
    public String toString() {
        return
                id +
                "," + name +
                "," + quantity +
                "," + dateAdded +
                "," + description +
                "," + area +
                "," + selling +
                "," + image +
                "," + category +
                "," + technicalInfo +'\''
                ;
    }


    //Dòng mới thêm
    public void setTotalProduct(int totalProduct) {
        this.totalProduct = totalProduct;
    }
}
