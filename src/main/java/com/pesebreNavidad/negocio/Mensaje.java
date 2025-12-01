package com.pesebreNavidad.negocio;

import com.pesebreNavidad.datos.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Mensaje {

    // =========================================================
    //                 ATRIBUTOS (MODELO)
    // =========================================================
    private int id;
    private String nombre;
    private String mensaje;
    private String fecha;

    // ==== GETTERS & SETTERS ====

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getMensaje() {
        return mensaje;
    }
    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getFecha() {
        return fecha;
    }
    public void setFecha(String fecha) {
        this.fecha = fecha;
    }




    // =========================================================
    //                     MÉTODO GUARDAR
    // =========================================================
    public boolean guardar() {
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO mensajes_navidad(nombre, mensaje) VALUES (?, ?)"
            );

            ps.setString(1, this.nombre);
            ps.setString(2, this.mensaje);

            ps.executeUpdate();
            con.close();
            return true;

        } catch (Exception e) {
            System.out.println("❌ Error guardando mensaje: " + e.getMessage());
            return false;
        }
    }




    // =========================================================
    //                     MÉTODO LISTAR
    // =========================================================
    public List<Mensaje> listar() {
        List<Mensaje> lista = new ArrayList<>();

        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM mensajes_navidad ORDER BY fecha DESC"
            );

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Mensaje m = new Mensaje();

                m.setId(rs.getInt("id"));
                m.setNombre(rs.getString("nombre"));
                m.setMensaje(rs.getString("mensaje"));
                m.setFecha(rs.getString("fecha"));

                lista.add(m);
            }

            con.close();

        } catch (Exception e) {
            System.out.println("❌ Error listando mensajes: " + e.getMessage());
        }

        return lista;
    }
}
