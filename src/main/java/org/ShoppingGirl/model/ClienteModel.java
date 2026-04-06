package org.ShoppingGirl.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.ShoppingGirl.bean.entity.Cliente;
import org.ShoppingGirl.services.ClienteServices;

import org.ShoppingGirl.conexionBD.ConexionBD;

public class ClienteModel implements ClienteServices{

	@Override
	public int registrar(Cliente c) {
		 String sql = "insert into clientes(nombre, telefono, estado) values (?, ?, true)";

	        try (Connection cn = ConexionBD.getConexion();
	             PreparedStatement ps = cn.prepareStatement(sql)) {

	            ps.setString(1, c.getNombre());
	            ps.setString(2, c.getTelefono());

	            return ps.executeUpdate();

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return 0;
	    }
	
	@Override
	public int actualizar(Cliente c) {
		  String sql = "update clientes set nombre=?, telefono=? where id_cliente=?";

	        try (Connection cn = ConexionBD.getConexion();
	             PreparedStatement ps = cn.prepareStatement(sql)) {

	            ps.setString(1, c.getNombre());
	            ps.setString(2, c.getTelefono());
	            ps.setInt(3, c.getIdCliente());

	            return ps.executeUpdate();

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return 0;
	}

	@Override
	public Cliente obtener(int id) {
	       Cliente c = null;
	        String sql = "select * from clientes where id_cliente = ?";

	        try (Connection cn = ConexionBD.getConexion();
	             PreparedStatement ps = cn.prepareStatement(sql)) {

	            ps.setInt(1, id);

	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    c = new Cliente();
	                    c.setIdCliente(rs.getInt("id_cliente"));
	                    c.setNombre(rs.getString("nombre"));
	                    c.setTelefono(rs.getString("telefono"));
	                    c.setEstado(rs.getBoolean("estado"));
	                }
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return c;
	}

	@Override
	public int eliminar(int id) {
		String sql = "update clientes set estado = false where id_cliente=?";

        try (Connection cn = ConexionBD.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
	}

	@Override
	public List<Cliente> listar() {
		  List<Cliente> lista = new ArrayList<>();
	        String sql = "select * from clientes where estado = true order by id_cliente desc";

	        try (Connection cn = ConexionBD.getConexion();
	             PreparedStatement ps = cn.prepareStatement(sql);
	             ResultSet rs = ps.executeQuery()) {

	            while (rs.next()) {
	                Cliente c = new Cliente();
	                c.setIdCliente(rs.getInt("id_cliente"));
	                c.setNombre(rs.getString("nombre"));
	                c.setTelefono(rs.getString("telefono"));
	                c.setEstado(rs.getBoolean("estado"));
	                lista.add(c);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return lista;
	}

}
