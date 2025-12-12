package com.pesebreNavidad.datos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class connectbbdd {
	private Statement St; 
    private String driver;
    private String user;
    private String pwd;
    private String cadena;
    private Connection con;

    public connectbbdd() {
        this.driver ="org.postgresql.Driver";
        this.user="postgres";
        this.pwd="admin";
        this.cadena="jdbc:postgresql://localhost:5432/bd_pesebreNavidad";
        this.con=this.crearConexion();	
    }

    Connection crearConexion() {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {}

        try {
            Class.forName(getDriver()).newInstance();
            Connection con=DriverManager.getConnection(getCadena(),getUser(),getPwd());
            return con;
        } catch(Exception ee) {
            System.out.println("Error: " + ee.getMessage());
            return null;
        }
    }

    public Connection getConexion() { 
        return this.con; 
    }

    public String Ejecutar(String sql) {
        String result = "";
        try {
            St = getConexion().createStatement();
            int filas = St.executeUpdate(sql);  // << CORRECTO

            if (filas > 0) {
                result = "OK";
            } else {
                result = "Sin cambios";
            }

        } catch (Exception ex) {
            result = ex.getMessage();
            System.out.println("ERROR SQL: " + sql);
            System.out.println("Detalle: " + ex.getMessage());
        }
        return result;
    }

    public ResultSet Consulta(String sql) {
        ResultSet reg=null;
        try {
            St=getConexion().createStatement();
            reg=St.executeQuery(sql);
        } catch(Exception ee) {
            System.out.println("Error en consulta: " + ee.getMessage());
        }
        return reg;
    }

    String getDriver() { return this.driver; }
    String getUser() { return this.user; }
    String getPwd() { return this.pwd; }
    String getCadena() { return this.cadena; }
}
