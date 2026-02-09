package com.pesebreNavidad.seguridad;

import com.pesebreNavidad.datos.Conexion;
import java.sql.*;
import java.time.LocalDateTime;

public class Usuario {

    // --------------------------
    // CAMPOS
    // --------------------------
    private int id;
    private int perfil;        // 1 = Admin, 2 = Estudiante
    private int estadoCivil;
    private String cedula;
    private String nombre;
    private String correo;
    private String clave;
    private boolean activo;
    private LocalDateTime fechaRegistro;

    // --------------------------
    // CONSTRUCTOR
    // --------------------------
    public Usuario() {}

    // --------------------------
    // GETTERS & SETTERS
    // --------------------------
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPerfil() { return perfil; }
    public void setPerfil(int perfil) { this.perfil = perfil; }

    public int getEstadoCivil() { return estadoCivil; }
    public void setEstadoCivil(int estadoCivil) { this.estadoCivil = estadoCivil; }

    public String getCedula() { return cedula; }
    public void setCedula(String cedula) { this.cedula = cedula; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getClave() { return clave; }
    public void setClave(String clave) { this.clave = clave; }

    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }

    public LocalDateTime getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(LocalDateTime fechaRegistro) { this.fechaRegistro = fechaRegistro; }
    
    
    public ResultSet filtrarAuditoria(String tabla, String op, String fecha) {
        ResultSet rs = null;

        try {
            String sql = "SELECT * FROM auditoria.tb_auditoria WHERE 1=1";

            if (tabla != null && !tabla.isEmpty()) {
                sql += " AND tabla_aud ILIKE ?";
            }

            if (op != null && !op.isEmpty()) {
                sql += " AND operacion_aud = ?";
            }

            if (fecha != null && !fecha.isEmpty()) {
                sql += " AND DATE(fecha_aud) = ?";
            }

            sql += " ORDER BY fecha_aud DESC";

            Conexion con = new Conexion();
            PreparedStatement pst = con.getConexion().prepareStatement(sql);

            int index = 1;

            if (tabla != null && !tabla.isEmpty()) {
                pst.setString(index++, "%" + tabla + "%");
            }
            if (op != null && !op.isEmpty()) {
                pst.setString(index++, op);
            }
            if (fecha != null && !fecha.isEmpty()) {
                pst.setString(index++, fecha);
            }

            rs = pst.executeQuery();

        } catch (Exception e) {
            System.out.println("❌ Error en filtrarAuditoria(): " + e.getMessage());
        }

        return rs;
    }



    // ============================================================
    // ✔ MÉTODO PARA VERIFICAR LOGIN (NO PERMITE BLOQUEADOS)
    // ============================================================
    public boolean verificarUsuario(String correo, String clave) {
        boolean respuesta = false;
        String sql = "SELECT * FROM tb_usuario WHERE correo_us=? AND clave_us=? AND activo=TRUE";

        try {
            Conexion con = new Conexion();
            PreparedStatement ps = con.getConexion().prepareStatement(sql);

            ps.setString(1, correo);
            ps.setString(2, clave);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                respuesta = true;
                this.id = rs.getInt("id_us");
                this.nombre = rs.getString("nombre_us");
                this.correo = rs.getString("correo_us");
                this.clave = rs.getString("clave_us");
                this.perfil = rs.getInt("id_per");
                this.estadoCivil = rs.getInt("id_est");
                this.activo = rs.getBoolean("activo");
            }

        } catch (Exception e) {
            System.out.println("❌ Error verificando usuario: " + e.getMessage());
        }
        return respuesta;
    }


    // ============================================================
    // ✔ REGISTRAR ESTUDIANTE DESDE LA WEB
    // ============================================================
    public String ingresarEstudiante() {
        String sql = "INSERT INTO tb_usuario (id_per, id_est, nombre_us, cedula_us, correo_us, clave_us, fecha_reg, activo) "
                   + "VALUES (2, ?, ?, ?, ?, ?, NOW(), TRUE)";
        String resultado = "";

        try {
            Conexion con = new Conexion();
            PreparedStatement ps = con.getConexion().prepareStatement(sql);

            ps.setInt(1, this.estadoCivil);
            ps.setString(2, this.nombre);
            ps.setString(3, this.cedula);
            ps.setString(4, this.correo);
            ps.setString(5, this.clave);

            if (ps.executeUpdate() > 0) resultado = "OK";
            else resultado = "ERROR";

        } catch (Exception e) {
            resultado = "❌ " + e.getMessage();
        }

        return resultado;
    }


    // ============================================================
    // ✔ REGISTRAR USUARIO DESDE PANEL ADMIN
    // ============================================================
    public String ingresarUsuarioAdmin() {
        String sql = "INSERT INTO tb_usuario (id_per, id_est, nombre_us, cedula_us, correo_us, clave_us, fecha_reg, activo) "
                   + "VALUES (?, ?, ?, ?, ?, ?, NOW(), TRUE)";
        String resultado = "";

        try {
            Conexion con = new Conexion();
            PreparedStatement ps = con.getConexion().prepareStatement(sql);

            ps.setInt(1, this.perfil);
            ps.setInt(2, this.estadoCivil);
            ps.setString(3, this.nombre);
            ps.setString(4, this.cedula);
            ps.setString(5, this.correo);
            ps.setString(6, this.clave);

            if (ps.executeUpdate() > 0) resultado = "OK";
            else resultado = "ERROR";

        } catch (Exception e) {
            resultado = "❌ " + e.getMessage();
        }

        return resultado;
    }


    // ============================================================
    // ✔ ACTUALIZAR USUARIO
    // ============================================================
    public boolean actualizarUsuario() {
        boolean actualizado = false;
        String sql = "UPDATE tb_usuario SET nombre_us=?, correo_us=?, clave_us=?, id_est=?, id_per=? WHERE id_us=?";

        try {
            Conexion con = new Conexion();
            PreparedStatement ps = con.getConexion().prepareStatement(sql);

            ps.setString(1, this.nombre);
            ps.setString(2, this.correo);
            ps.setString(3, this.clave);
            ps.setInt(4, this.estadoCivil);
            ps.setInt(5, this.perfil);
            ps.setInt(6, this.id);

            actualizado = (ps.executeUpdate() > 0);

        } catch (Exception e) {
            System.out.println("❌ Error actualizando: " + e.getMessage());
        }

        return actualizado;
    }


    // ============================================================
    // ✔ MÉTODO PARA BLOQUEAR UN USUARIO
    // ============================================================
    public boolean bloquearUsuario(int idUsuario) {
        boolean ok = false;
        String sql = "UPDATE tb_usuario SET activo=FALSE WHERE id_us=?";

        try {
            Conexion con = new Conexion();
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idUsuario);

            ok = (ps.executeUpdate() > 0);

        } catch (Exception e) {
            System.out.println("❌ Error bloqueando usuario: " + e.getMessage());
        }

        return ok;
    }


    // ============================================================
    // ✔ MÉTODO PARA ACTIVAR UN USUARIO
    // ============================================================
    public boolean activarUsuario(int idUsuario) {
        boolean ok = false;
        String sql = "UPDATE tb_usuario SET activo=TRUE WHERE id_us=?";

        try {
            Conexion con = new Conexion();
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idUsuario);

            ok = (ps.executeUpdate() > 0);

        } catch (Exception e) {
            System.out.println("❌ Error activando usuario: " + e.getMessage());
        }

        return ok;
    }


    // ============================================================
    // ✔ LISTA DE USUARIOS (TABLA PARA ADMIN)
    // ============================================================
    public ResultSet listarUsuarios() {
        ResultSet rs = null;
        String sql = "SELECT * FROM tb_usuario WHERE id_per != 1 ORDER BY id_us";

        try {
            Conexion con = new Conexion();
            rs = con.Consulta(sql);

        } catch (Exception e) {
            System.out.println("❌ Error listando usuarios: " + e.getMessage());
        }

        return rs;
    }
    
    public boolean eliminarUsuario(int idUsuario) {
        boolean ok = false;
        String sql = "DELETE FROM tb_usuario WHERE id_us=?";

        try {
            Conexion con = new Conexion();
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idUsuario);

            ok = (ps.executeUpdate() > 0);

        } catch (Exception e) {
            System.out.println("❌ Error eliminando usuario: " + e.getMessage());
        }

        return ok;
    }

    // ============================================================
    // ✔ REGISTRAR AUDITORÍA (INSERTA EN LA TABLA auditoria.tb_auditoria)
    // ============================================================
    public void registrarAuditoria(String tabla, String operacion, String valorAnterior, String valorNuevo, String usuario) {
        String sql = "INSERT INTO auditoria.tb_auditoria (tabla_aud, operacion_aud, valoranterior_aud, valornuevo_aud, usuario_aud, fecha_aud) "
                   + "VALUES (?, ?, ?, ?, ?, NOW())";

        try {
            Conexion con = new Conexion();
            PreparedStatement ps = con.getConexion().prepareStatement(sql);

            ps.setString(1, tabla);
            ps.setString(2, operacion);  // I, U, D
            ps.setString(3, valorAnterior);
            ps.setString(4, valorNuevo);
            ps.setString(5, usuario);

            ps.executeUpdate();
            con.getConexion().close();

        } catch (Exception e) {
            System.out.println("❌ Error registrando auditoría: " + e.getMessage());
        }
    }

}
