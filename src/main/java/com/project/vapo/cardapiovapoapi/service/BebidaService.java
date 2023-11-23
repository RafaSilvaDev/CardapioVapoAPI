package com.project.vapo.cardapiovapoapi.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.vapo.cardapiovapoapi.model.Bebida;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.List;

@Service
public class BebidaService {
    private List<Bebida> bebidas;

    public BebidaService() {
        try {
            InputStream inputStream = getClass().getClassLoader().getResourceAsStream("data.json");
            ObjectMapper objectMapper = new ObjectMapper();
            bebidas = Arrays.asList(objectMapper.readValue(inputStream, Bebida[].class));
        } catch (IOException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "Fail to load image by base64. Java Exception: " + e);
        }
    }

    public List<Bebida> listarBebidas() {
        return bebidas;
    }
}
