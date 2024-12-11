package models;

import java.time.LocalDateTime;
import java.util.Date;

public class Product {
    private int id;
    private String name;
    private int quantity;
    private LocalDateTime dateAdded;
    private String description;
    private double area;
    private int selling;
    private String image;
    private Category category;
    private TechnicalInfo technicalInfo;

    public int getId() {
        return id;
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

    public LocalDateTime getDateAdded() {
        return dateAdded;
    }

    public void setDate(LocalDateTime dateAdded) {
        this.dateAdded = dateAdded;
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

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", quantity=" + quantity +
                ", date=" + dateAdded +
                ", description='" + description + '\'' +
                ", area=" + area +
                ", selling=" + selling +
                ", image='" + image + '\'' +
                ", category=" + category +
                ", technicalInfo=" + technicalInfo +
                '}';
    }
}
