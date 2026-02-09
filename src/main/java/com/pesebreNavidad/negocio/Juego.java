package com.pesebreNavidad.seguridad;

public class Juego {
    private int idJuego;
    private int idUsuario;
    private String tipoJuego;
    private int puntaje;
    private String fechaJuego;
    private String nombreUsuario; // Para mostrar en consultas

    public Juego() {}

    public Juego(int idJuego, int idUsuario, String tipoJuego, int puntaje, String fechaJuego) {
        this.idJuego = idJuego;
        this.idUsuario = idUsuario;
        this.tipoJuego = tipoJuego;
        this.puntaje = puntaje;
        this.fechaJuego = fechaJuego;
    }

    // Getters y Setters
    public int getIdJuego() { return idJuego; }
    public void setIdJuego(int idJuego) { this.idJuego = idJuego; }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public String getTipoJuego() { return tipoJuego; }
    public void setTipoJuego(String tipoJuego) { this.tipoJuego = tipoJuego; }

    public int getPuntaje() { return puntaje; }
    public void setPuntaje(int puntaje) { this.puntaje = puntaje; }

    public String getFechaJuego() { return fechaJuego; }
    public void setFechaJuego(String fechaJuego) { this.fechaJuego = fechaJuego; }

    public String getNombreUsuario() { return nombreUsuario; }
    public void setNombreUsuario(String nombreUsuario) { this.nombreUsuario = nombreUsuario; }
}