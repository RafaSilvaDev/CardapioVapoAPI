package com.project.vapo.cardapiovapoapi.controller;

import com.project.vapo.cardapiovapoapi.model.Bebida;
import com.project.vapo.cardapiovapoapi.service.BebidaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/bebidas")
public class BebidaController {
    @Autowired
    private BebidaService bebidaService;

    @GetMapping
    public List<Bebida> getBebidas() {
        return bebidaService.listarBebidas();
    }
}
