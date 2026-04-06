package org.ShoppingGirl.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.ShoppingGirl.services.VentaServices;

import org.ShoppingGirl.conexionBD.ConexionBD;
import org.ShoppingGirl.bean.entity.Venta;
import org.ShoppingGirl.bean.entity.DetalleVenta;

public class VentaModel implements VentaServices {

	@Override
	public int registrarVenta(Venta venta) {
		   Connection cn = null;
	        int idVenta = 0;

	        String sqlVenta = "insert into ventas(id_cliente, id_usuario, total) values (?, ?, ?)";
	        String sqlDetalle = "insert into detalle_venta(id_venta, id_producto, cantidad, precio, subtotal) values (?, ?, ?, ?, ?)";
	        String sqlStock = "update productos set stock = stock - ? where id_producto = ? and stock >= ?";

	        try {
	            cn = ConexionBD.getConexion();
	            cn.setAutoCommit(false);

	            try (PreparedStatement psVenta = cn.prepareStatement(sqlVenta, Statement.RETURN_GENERATED_KEYS)) {
	                psVenta.setInt(1, venta.getIdCliente());
	                psVenta.setInt(2, venta.getIdUsuario());
	                psVenta.setDouble(3, venta.getTotal());
	                psVenta.executeUpdate();

	                try (ResultSet rs = psVenta.getGeneratedKeys()) {
	                    if (rs.next()) {
	                        idVenta = rs.getInt(1);
	                    }
	                }
	            }

	            for (DetalleVenta d : venta.getDetalles()) {

	                try (PreparedStatement psDetalle = cn.prepareStatement(sqlDetalle)) {
	                    psDetalle.setInt(1, idVenta);
	                    psDetalle.setInt(2, d.getIdProducto());
	                    psDetalle.setInt(3, d.getCantidad());
	                    psDetalle.setDouble(4, d.getPrecio());
	                    psDetalle.setDouble(5, d.getSubtotal());
	                    psDetalle.executeUpdate();
	                }

	                try (PreparedStatement psStock = cn.prepareStatement(sqlStock)) {
	                    psStock.setInt(1, d.getCantidad());
	                    psStock.setInt(2, d.getIdProducto());
	                    psStock.setInt(3, d.getCantidad());

	                    int filas = psStock.executeUpdate();

	                    if (filas == 0) {
	                        throw new RuntimeException("Stock insuficiente para el producto " + d.getIdProducto());
	                    }
	                }
	            }

	            cn.commit();

	        } catch (Exception e) {
	            e.printStackTrace();
	            try {
	                if (cn != null) {
	                    cn.rollback();
	                }
	            } catch (Exception ex) {
	                ex.printStackTrace();
	            }
	            return 0;

	        } finally {
	            try {
	                if (cn != null) {
	                    cn.setAutoCommit(true);
	                    cn.close();
	                }
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }

	        return idVenta;
	}

	@Override
	public List<Venta> consultarVentas(String fechaInicio, String fechaFin, String cliente) {
		   List<Venta> lista = new ArrayList<>();

	        String sql = "select v.id_venta, v.fecha, v.total, c.nombre as nombre_cliente " +
	                     "from ventas v " +
	                     "inner join clientes c on v.id_cliente = c.id_cliente " +
	                     "where cast(v.fecha as date) between ? and ? " +
	                     "and upper(c.nombre) like upper(?) " +
	                     "order by v.id_venta desc";

	        try (Connection cn = ConexionBD.getConexion();
	             PreparedStatement ps = cn.prepareStatement(sql)) {

	            ps.setString(1, fechaInicio);
	            ps.setString(2, fechaFin);
	            ps.setString(3, "%" + cliente + "%");

	            try (ResultSet rs = ps.executeQuery()) {
	                while (rs.next()) {
	                    Venta v = new Venta();
	                    v.setIdVenta(rs.getInt("id_venta"));
	                    v.setFecha(rs.getString("fecha"));
	                    v.setNombreCliente(rs.getString("nombre_cliente"));
	                    v.setTotal(rs.getDouble("total"));
	                    lista.add(v);
	                }
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return lista;
	}

	@Override
	public List<Venta> reporteVentasMensuales() {
	    List<Venta> lista = new ArrayList<>();

        String sql = "select to_char(fecha, 'YYYY-MM') as periodo, sum(total) as total " +
                     "from ventas " +
                     "group by to_char(fecha, 'YYYY-MM') " +
                     "order by periodo desc";

        try (Connection cn = ConexionBD.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Venta v = new Venta();
                v.setFecha(rs.getString("periodo"));
                v.setTotal(rs.getDouble("total"));
                lista.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
	}

}
