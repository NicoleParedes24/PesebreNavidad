package com.pesebreNavidad.negocio;

import com.pesebreNavidad.datos.connectbbdd;
import java.sql.*;
import java.util.ArrayList;

public class Votar {

    public static class Pesebre {
        public int id;
        public String carrera;
        public String imagen;
    }

    public static class Ranking {
        public String carrera;
        public int votos;
    }

    private connectbbdd con;

    public Votar() {
        con = new connectbbdd();
    }

    // =============================
    // LISTA DE PESEBRES
    // =============================
    public ArrayList<Pesebre> obtenerPesebres() {
        ArrayList<Pesebre> lista = new ArrayList<>();

        try {
            String sql = "SELECT id_galeria, carrera, imagen FROM tb_galeria ORDER BY carrera ASC";
            ResultSet rs = con.Consulta(sql);

            while (rs.next()) {
                Pesebre p = new Pesebre();
                p.id = rs.getInt("id_galeria");
                p.carrera = rs.getString("carrera");
                p.imagen = rs.getString("imagen");
                lista.add(p);
            }

        } catch (Exception e) {
            System.out.println("Error obtenerPesebres(): " + e.getMessage());
        }

        return lista;
    }

    // =============================
    // VERIFICAR SI YA VOTÓ
    // =============================
    public boolean yaVoto(int idUsuario) {
        try {
            String sql = "SELECT COUNT(*) FROM tb_voto WHERE id_usuario = ?";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idUsuario);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;

        } catch (Exception e) {
            System.out.println("Error yaVoto(): " + e.getMessage());
        }

        return false;
    }

    // =============================
    // REGISTRAR VOTO
    // =============================
    public boolean registrarVoto(int idUsuario, int idPesebre) {
        try {
            String sql = "INSERT INTO tb_voto(id_usuario, id_galeria) VALUES (?, ?)";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idUsuario);
            ps.setInt(2, idPesebre);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Error registrarVoto(): " + e.getMessage());
            return false;
        }
    }

    // =============================
    // RANKING
    // =============================
    public ArrayList<Ranking> obtenerRanking() {
        ArrayList<Ranking> lista = new ArrayList<>();

        try {
            String sql =
                "SELECT g.carrera, COUNT(v.id_galeria) AS votos " +
                "FROM tb_galeria g " +
                "LEFT JOIN tb_voto v ON g.id_galeria = v.id_galeria " +
                "GROUP BY g.carrera " +
                "ORDER BY votos DESC";

            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Ranking r = new Ranking();
                r.carrera = rs.getString("carrera");
                r.votos = rs.getInt("votos");
                lista.add(r);
            }

        } catch (Exception e) {
            System.out.println("Error obtenerRanking(): " + e.getMessage());
        }

        return lista;
    }
}
