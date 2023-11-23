package com.project.vapo.cardapiovapoapi.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Bebida {
    private Long id;
    private String name;
    private int size_ml;
    private double cost;
    private String image_base64;
}
