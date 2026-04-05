package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import conexion.ConexionBD;
import model.UsuarioModel;

public class UsuarioService {

    public UsuarioModel login(String correo, String clave) {
        UsuarioModel usuario = null;

        String sql = "select u.id_usuario, u.nombres, u.correo, u.id_rol, r.nombre as nombre_rol " +
                     "from usuarios u " +
                     "inner join roles r on u.id_rol = r.id_rol " +
                     "where u.correo = ? and u.clave = ? and u.estado = true";

        try (Connection cn = ConexionBD.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, correo);
            ps.setString(2, clave);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new UsuarioModel();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    usuario.setNombres(rs.getString("nombres"));
                    usuario.setCorreo(rs.getString("correo"));
                    usuario.setIdRol(rs.getInt("id_rol"));
                    usuario.setNombreRol(rs.getString("nombre_rol"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return usuario;
    }
}