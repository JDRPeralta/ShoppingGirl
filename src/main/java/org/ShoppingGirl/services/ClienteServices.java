package org.ShoppingGirl.services;

import java.util.List;

import org.ShoppingGirl.bean.entity.Cliente;

public interface ClienteServices {

	public int registrar(Cliente c);
	
	public int actualizar(Cliente c);
	
	public Cliente obtener(int id);
	
	public int eliminar(int id);
	
	public List<Cliente> listar();
}
