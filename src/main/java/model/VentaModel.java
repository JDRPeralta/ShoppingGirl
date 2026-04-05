package model;

import java.util.ArrayList;
import java.util.List;

public class VentaModel {

    private int idVenta;
    private int idCliente;
    private int idUsuario;
    private String nombreCliente;
    private String fecha;
    private double total;
    private List<DetalleVentaModel> detalles = new ArrayList<>();

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public List<DetalleVentaModel> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<DetalleVentaModel> detalles) {
        this.detalles = detalles;
    }
}