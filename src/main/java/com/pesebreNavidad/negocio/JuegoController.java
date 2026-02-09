package com.pesebreNavidad.negocio;

import com.navidad.datos.Conexion;
import com.navidad.modelo.Juego;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JuegoController {
    private Conexion con;

    public JuegoController() {
        con = new Conexion();
    }

    public String guardarPuntaje(Juego juego) {
        String sql = String.format(
            "INSERT INTO juego (id_usuario, tipo_juego, puntaje) VALUES (%d, '%s', %d)",
            juego.getIdUsuario(), juego.getTipoJuego(), juego.getPuntaje()
        );
        return con.Ejecutar(sql);
    }

    public List<Juego> listarPuntajesPorUsuario(int idUsuario) {
        List<Juego> juegos = new ArrayList<>();
        String sql = String.format(
            "SELECT * FROM juego WHERE id_usuario = %d ORDER BY fecha_juego DESC", idUsuario);
        ResultSet rs = con.Consulta(sql);
        try {
            while (rs.next()) {
                juegos.add(new Juego(
                    rs.getInt("id_juego"),
                    rs.getInt("id_usuario"),
                    rs.getString("tipo_juego"),
                    rs.getInt("puntaje"),
                    rs.getString("fecha_juego")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error listando puntajes: " + e.getMessage());
        } finally {
            con.cerrarConexion();
        }
        return juegos;
    }

    public List<Juego> listarMejoresPuntajes(String tipoJuego) {
        List<Juego> juegos = new ArrayList<>();
        String sql = String.format(
            "SELECT j.*, u.nombre || ' ' || u.apellido as nombre_usuario " +
            "FROM juego j JOIN usuario u ON j.id_usuario = u.id_usuario " +
            "WHERE j.tipo_juego = '%s' ORDER BY j.puntaje DESC LIMIT 10", tipoJuego);
        ResultSet rs = con.Consulta(sql);
        try {
            while (rs.next()) {
                Juego juego = new Juego(
                    rs.getInt("id_juego"),
                    rs.getInt("id_usuario"),
                    rs.getString("tipo_juego"),
                    rs.getInt("puntaje"),
                    rs.getString("fecha_juego")
                );
                juego.setNombreUsuario(rs.getString("nombre_usuario"));
                juegos.add(juego);
            }
        } catch (SQLException e) {
            System.out.println("Error listando mejores puntajes: " + e.getMessage());
        } finally {
            con.cerrarConexion();
        }
        return juegos;
    }

    public int obtenerMejorPuntajeUsuario(int idUsuario, String tipoJuego) {
        String sql = String.format(
            "SELECT MAX(puntaje) as mejor_puntaje FROM juego " +
            "WHERE id_usuario = %d AND tipo_juego = '%s'", idUsuario, tipoJuego);
        ResultSet rs = con.Consulta(sql);
        try {
            if (rs.next()) {
                return rs.getInt("mejor_puntaje");
            }
        } catch (SQLException e) {
            System.out.println("Error obteniendo mejor puntaje: " + e.getMessage());
        } finally {
            con.cerrarConexion();
        }
        return 0;
    }
}