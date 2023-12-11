package model;

public class Bebida {
    private int id;
    private String name;
    private int size_ml;
    private double cost;
    private String image_base64;

    // Construtor
    public Bebida(int id, String name, int size_ml, double cost, String image_base64) {
        this.id = id;
        this.name = name;
        this.size_ml = size_ml;
        this.cost = cost;
        this.image_base64 = image_base64;
    }

    // Getters e Setters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getSize_ml() {
        return size_ml;
    }

    public double getCost() {
        return cost;
    }

    public String getImage_base64() {
        return image_base64;
    }
}

