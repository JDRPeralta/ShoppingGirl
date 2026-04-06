package org.ShoppingGirl.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.ShoppingGirl.services.ProductoServices;
import org.ShoppingGirl.conexionBD.ConexionBD;
import org.ShoppingGirl.bean.entity.Producto;
public class ProductoModel implements ProductoServices{

	@Override
	public List<Producto> listar() {
	    List<Producto> lista = new ArrayList<>();

        String sql = "select p.*, pr.nombre as nombre_proveedor " +
                     "from productos p " +
                     "left join proveedores pr on p.id_proveedor = pr.id_proveedor " +
                     "where p.estado = true " +
                     "order by p.id_producto desc";

        try (Connection cn = ConexionBD.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setTalla(rs.getString("talla"));
                p.setColor(rs.getString("color"));
                p.setPrecioCompra(rs.getDouble("precio_compra"));
                p.setPrecioVenta(rs.getDouble("precio_venta"));
                p.setStock(rs.getInt("stock"));
                p.setIdProveedor(rs.getInt("id_proveedor"));
                p.setNombreProveedor(rs.getString("nombre_proveedor"));
                p.setEstado(rs.getBoolean("estado"));
                lista.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;

	}

	@Override
	public Producto obtener(int id) {
	     Producto p = null;
	        String sql = "select * from productos where id_producto = ?";

	        try (Connection cn = ConexionBD.getConexion();
	             PreparedStatement ps = cn.prepareStatement(sql)) {

	            ps.setInt(1, id);

	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    p = new Producto();
	                    p.setIdProducto(rs.getInt("id_producto"));
	                    p.setNombre(rs.getString("nombre"));
	                    p.setDescripcion(rs.getString("descripcion"));
	                    p.setTalla(rs.getString("talla"));
	                    p.setColor(rs.getString("color"));
	                    p.setPrecioCompra(rs.getDouble("precio_compra"));
	                    p.setPrecioVenta(rs.getDouble("precio_venta"));
	                    p.setStock(rs.getInt("stock"));
	                    p.setIdProveedor(rs.getInt("id_proveedor"));
	                    p.setEstado(rs.getBoolean("estado"));
	                }
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return p;

	}

	@Override
	public int registrar(Producto p) {
     String sql = "insert into productos(nombre, descripcion, talla, color, precio_compra, precio_venta, stock, id_proveedor, estado) " +
        "values (?, ?, ?, ?, ?, ?, ?, ?, true)";

		try (Connection cn = ConexionBD.getConexion();
		    PreparedStatement ps = cn.prepareStatement(sql)) {
		
		   ps.setString(1, p.getNombre());
		   ps.setString(2, p.getDescripcion());
		   ps.setString(3, p.getTalla());
		   ps.setString(4, p.getColor());
		   ps.setDouble(5, p.getPrecioCompra());
		   ps.setDouble(6, p.getPrecioVenta());
		   ps.setInt(7, p.getStock());
		   ps.setInt(8, p.getIdProveedor());
		
		   return ps.executeUpdate();
		
		} catch (Exception e) {
		   e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int actualizar(Producto p) {
	    String sql = "update productos set nombre=?, descripcion=?, talla=?, color=?, precio_compra=?, precio_venta=?, stock=?, id_proveedor=? " +
                "where id_producto=?";

   try (Connection cn = ConexionBD.getConexion();
        PreparedStatement ps = cn.prepareStatement(sql)) {

       ps.setString(1, p.getNombre());
       ps.setString(2, p.getDescripcion());
       ps.setString(3, p.getTalla());
       ps.setString(4, p.getColor());
       ps.setDouble(5, p.getPrecioCompra());
       ps.setDouble(6, p.getPrecioVenta());
       ps.setInt(7, p.getStock());
       ps.setInt(8, p.getIdProveedor());
       ps.setInt(9, p.getIdProducto());

       return ps.executeUpdate();

   } catch (Exception e) {
       e.printStackTrace();
   }
   return 0;

	}

	@Override
	public int eliminar(int id) {
		   String sql = "update productos set estado = false where id_producto=?";

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
	public List<Producto> consultar(String texto) {
		   List<Producto> lista = new ArrayList<>();

	        String sql = "select p.*, pr.nombre as nombre_proveedor " +
	                     "from productos p " +
	                     "left join proveedores pr on p.id_proveedor = pr.id_proveedor " +
	                     "where p.estado = true and (" +
	                     "upper(p.nombre) like upper(?) or " +
	                     "upper(p.talla) like upper(?) or " +
	                     "upper(p.color) like upper(?)) " +
	                     "order by p.id_producto desc";

	        try (Connection cn = ConexionBD.getConexion();
	             PreparedStatement ps = cn.prepareStatement(sql)) {

	            String filtro = "%" + texto + "%";
	            ps.setString(1, filtro);
	            ps.setString(2, filtro);
	            ps.setString(3, filtro);

	            try (ResultSet rs = ps.executeQuery()) {
	                while (rs.next()) {
	                    Producto p = new Producto();
	                    p.setIdProducto(rs.getInt("id_producto"));
	                    p.setNombre(rs.getString("nombre"));
	                    p.setDescripcion(rs.getString("descripcion"));
	                    p.setTalla(rs.getString("talla"));
	                    p.setColor(rs.getString("color"));
	                    p.setPrecioVenta(rs.getDouble("precio_venta"));
	                    p.setStock(rs.getInt("stock"));
	                    p.setNombreProveedor(rs.getString("nombre_proveedor"));
	                    lista.add(p);
	                }
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return lista;

	}

	@Override
	public List<Producto> reporteStockBajo(int limite) {
	    List<Producto> lista = new ArrayList<>();

        String sql = "select p.*, pr.nombre as nombre_proveedor " +
                     "from productos p " +
                     "left join proveedores pr on p.id_proveedor = pr.id_proveedor " +
                     "where p.estado = true and p.stock <= ? " +
                     "order by p.stock asc";

        try (Connection cn = ConexionBD.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, limite);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Producto p = new Producto();
                    p.setIdProducto(rs.getInt("id_producto"));
                    p.setNombre(rs.getString("nombre"));
                    p.setTalla(rs.getString("talla"));
                    p.setColor(rs.getString("color"));
                    p.setStock(rs.getInt("stock"));
                    p.setNombreProveedor(rs.getString("nombre_proveedor"));
                    lista.add(p);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
	}

}
