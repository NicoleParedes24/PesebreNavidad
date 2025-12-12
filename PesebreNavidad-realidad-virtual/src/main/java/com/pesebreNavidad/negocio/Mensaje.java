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
    private boolean aprobado;


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

    public boolean isAprobado() {
        return aprobado;
    }
    public void setAprobado(boolean aprobado) {
        this.aprobado = aprobado;
    }

    
    // =========================================================
    //                 CONSTRUCTOR NECESARIO
    // =========================================================
    public Mensaje() {}

    public Mensaje(int id, String nombre, String mensaje) {
        this.id = id;
        this.nombre = nombre;
        this.mensaje = mensaje;
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
                m.setAprobado(rs.getBoolean("aprobado"));


                lista.add(m);
            }

            con.close();

        } catch (Exception e) {
            System.out.println("❌ Error listando mensajes: " + e.getMessage());
        }

        return lista;
    }


    // =========================================================
    //                     MÉTODO OBTENER(ID)
    // =========================================================
    public Mensaje obtener(int id) {
        Mensaje m = null;

        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM mensajes_navidad WHERE id = ?"
            );
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                m = new Mensaje(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("mensaje")
                );
                m.setFecha(rs.getString("fecha"));
            }

            con.close();

        } catch (Exception e) {
            System.out.println("❌ Error obteniendo mensaje: " + e.getMessage());
        }

        return m;
    }


    // =========================================================
    //                     MÉTODO ACTUALIZAR
    // =========================================================
    public void actualizar(Mensaje m) {
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE mensajes_navidad SET nombre=?, mensaje=? WHERE id=?"
            );

            ps.setString(1, m.getNombre());
            ps.setString(2, m.getMensaje());
            ps.setInt(3, m.getId());

            ps.executeUpdate();
            con.close();

        } catch (Exception e) {
            System.out.println("❌ Error actualizando mensaje: " + e.getMessage());
        }
    }


    // =========================================================
    //                     MÉTODO ELIMINAR
    // =========================================================
    public void eliminar(int id) {
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM mensajes_navidad WHERE id = ?"
            );

            ps.setInt(1, id);
            ps.executeUpdate();

            con.close();

        } catch (Exception e) {
            System.out.println("❌ Error eliminando mensaje: " + e.getMessage());
        }
    }
    
    public void cambiarEstado(int id, boolean aprobado) {
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE mensajes_navidad SET aprobado=? WHERE id=?"
            );

            ps.setBoolean(1, aprobado);
            ps.setInt(2, id);
            ps.executeUpdate();

            con.close();

        } catch (Exception e) {
            System.out.println("❌ Error cambiando estado del mensaje: " + e.getMessage());
        }
    }

    

}
