package org.ShoppingGirl.services;

import java.util.List;

import org.ShoppingGirl.bean.entity.Venta;

public interface VentaServices {
	
	public int registrarVenta(Venta venta);
	
	public List<Venta> consultarVentas(String fechaInicio, String fechaFin, String cliente);
	
	public List<Venta> reporteVentasMensuales();

}
