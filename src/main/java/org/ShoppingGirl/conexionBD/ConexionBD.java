package org.ShoppingGirl.conexionBD;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    private static final String URL = "jdbc:postgresql://aws-1-us-west-2.pooler.supabase.com:5432/postgres?sslmode=require";
    private static final String USUARIO = "postgres.ripgyclmxrucnignisji";
    private static final String CONTRASENA = "PROYECTOFINAL";
    public static Connection getConexion() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver no encontrado", e);
        }
        return DriverManager.getConnection(URL, USUARIO, CONTRASENA);
    }
}