package models;

import java.io.Serializable;
import java.util.Objects;

public class Style  implements Serializable {
    private int id;
    private Product product;
    private String name;
    private String image;
    private int quantity;


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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Style(int id, Product product, String name, String image, int quantity) {
        this.id = id;
        this.product = product;
        this.name = name;
        this.image = image;
        this.quantity = quantity;
    }

    public Style() {

    }

    @Override
    public String toString() {
        return "Style{" +
                "id=" + id +
                ", product=" + product +
                ", name='" + name + '\'' +
                ", image='" + image + '\'' +
                ", quantity=" + quantity +
                '}';
    }

    //Dong moi them
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Style style = (Style) o;
        return id == style.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }


}
