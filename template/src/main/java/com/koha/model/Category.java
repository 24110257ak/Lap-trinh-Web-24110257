package com.koha.model;

import java.io.Serializable;

public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String icon;

    public Category() {
    }

    public Category(int id, String name, String icon) {
        this.id = id;
        this.name = name;
        this.icon = icon;
    }

    public Category(String name, String icon) {
        this.name = name;
        this.icon = icon;
    }

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

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    // Alias methods to support both naming conventions in slides (cateid, catename, icons)
    public int getCateid() {
        return id;
    }

    public void setCateid(int cateid) {
        this.id = cateid;
    }

    public String getCatename() {
        return name;
    }

    public void setCatename(String catename) {
        this.name = catename;
    }

    public String getIcons() {
        return icon;
    }

    public void setIcons(String icons) {
        this.icon = icons;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", icon='" + icon + '\'' +
                '}';
    }
}
