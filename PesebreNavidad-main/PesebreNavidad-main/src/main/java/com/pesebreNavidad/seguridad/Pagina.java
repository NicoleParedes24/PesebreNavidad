package com.pesebreNavidad.seguridad;

import java.sql.ResultSet;
import java.sql.SQLException;
import com.pesebreNavidad.datos.Conexion;

public class Pagina {

    public String mostrarMenu(Integer nperfil) {
        String menu = 
            "<nav class=\"navbar navbar-expand-lg bg-light shadow-sm mb-4\">" +
            "  <div class=\"container-fluid\">" +
            "    <a class=\"navbar-brand\" href=\"#\">🎄 Navegación</a>" +
            "    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\">" +
            "      <span class=\"navbar-toggler-icon\"></span>" +
            "    </button>" +
            "    <div class=\"collapse navbar-collapse\" id=\"navbarNav\">" +
            "      <ul class=\"navbar-nav\">";

        String sql = "SELECT pag.id_pag, pag.descripcion_pag, pag.path_pag "
                + "FROM tb_pagina pag "
                + "JOIN tb_perfilpagina pper ON pag.id_pag = pper.id_pag "
                + "WHERE pper.id_per = " + nperfil + " "
                + "ORDER BY pag.id_pag ASC";

        Conexion con = new Conexion();
        ResultSet rs = null;

        try {
            rs = con.Consulta(sql);
            while (rs.next()) {
                menu += "<li class=\"nav-item\">" +
                        "<a class=\"nav-link\" href=\"" + rs.getString("path_pag") + "\">" +
                        rs.getString("descripcion_pag") + "</a>" +
                        "</li>";
            }
        } catch (SQLException e) {
            System.out.println("❌ Error al generar menú: " + e.getMessage());
        }

        menu += "      </ul></div></div></nav>";

        return menu;
    }
}
