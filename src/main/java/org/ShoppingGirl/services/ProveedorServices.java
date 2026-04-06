package org.ShoppingGirl.services;

import java.util.List;

import org.ShoppingGirl.bean.entity.Proveedor;

public interface ProveedorServices {

	public List<Proveedor> listar();
	
	public Proveedor obtener(int id);
	
	public int registrar(Proveedor p);
	
	public int actualizar(Proveedor p);
	
	public int eliminar(int id);
	
}
