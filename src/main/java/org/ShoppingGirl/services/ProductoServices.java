package org.ShoppingGirl.services;

import java.util.List;

import org.ShoppingGirl.bean.entity.Producto;

public interface ProductoServices {

	public List<Producto> listar();
	
	public Producto obtener(int id);
	
	public int registrar(Producto p);
	
	public int actualizar(Producto p);
	
	public int eliminar(int id);
	
	public List<Producto> consultar(String texto);
	
	public List<Producto> reporteStockBajo(int limite);
	
}
