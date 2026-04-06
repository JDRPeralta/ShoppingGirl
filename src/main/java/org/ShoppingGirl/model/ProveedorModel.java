package org.ShoppingGirl.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.ShoppingGirl.services.ProveedorServices;
import org.ShoppingGirl.bean.entity.Proveedor;
import org.ShoppingGirl.conexionBD.ConexionBD;

public class ProveedorModel implements ProveedorServices{

	@Override
	public List<Proveedor> listar() {
	    List<Proveedor> lista = new ArrayList<>();
        String sql = "select * from proveedores where estado = true order by id_proveedor desc";

        try (Connection cn = ConexionBD.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Proveedor p = new Proveedor();
                p.setIdProveedor(rs.getInt("id_proveedor"));
                p.setNombre(rs.getString("nombre"));
                p.setTelefono(rs.getString("telefono"));
                p.setPais(rs.getString("pais"));
                p.setEstado(rs.getBoolean("estado"));
                lista.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
	}

	@Override
	public Proveedor obtener(int id) {
	    Proveedor p = null;
        String sql = "select * from proveedores where id_proveedor = ?";

        try (Connection cn = ConexionBD.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Proveedor();
                    p.setIdProveedor(rs.getInt("id_proveedor"));
                    p.setNombre(rs.getString("nombre"));
                    p.setTelefono(rs.getString("telefono"));
                    p.setPais(rs.getString("pais"));
                    p.setEstado(rs.getBoolean("estado"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
	}

	@Override
	public int registrar(Proveedor p) {
	     String sql = "insert into proveedores(nombre, telefono, pais, estado) values (?, ?, ?, true)";

	        try (Connection cn = ConexionBD.getConexion();
	             PreparedStatement ps = cn.prepareStatement(sql)) {

	            ps.setString(1, p.getNombre());
	            ps.setString(2, p.getTelefono());
	            ps.setString(3, p.getPais());

	            return ps.executeUpdate();

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return 0;
	}

	@Override
	public int actualizar(Proveedor p) {
	    String sql = "update proveedores set nombre=?, telefono=?, pais=? where id_proveedor=?";

        try (Connection cn = ConexionBD.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getTelefono());
            ps.setString(3, p.getPais());
            ps.setInt(4, p.getIdProveedor());

            return ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
	}

	@Override
	public int eliminar(int id) {
	    String sql = "update proveedores set estado = false where id_proveedor=?";

        try (Connection cn = ConexionBD.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;	
	}

}
