import org.postgresql.core.BaseStatement;

import java.sql.*;
import java.sql.Types

public class App {
    public static void main(String args[]) throws SQLException {
        Connection c = null;

        try {
            Class.forName("org.postgresql.Driver");
            c = DriverManager
                    .getConnection("jdbc:postgresql://localhost:5432/bootcamp_market",
                            "postgres", "postgres");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

        CallableStatement cs = null;
        ResultSet rs = null;
        //query 1
        cs = c.prepareCall("SELECT nombre, count(*) FROM cliente AS A INNER JOIN factura AS B ON A.id = B.cliente_id GROUP BY(A.id) ORDER BY count(*) DESC");
        cs.execute();
        rs = cs.getResultSet();


        while (rs.next())
            System.out.println("NOMBRE " + rs.getString(1) + " PRODUCTO SIN IVA " + rs.getInt(2));

        //QUERY2
        cs = c.prepareCall("SELECT d.nombre, SUM(ROUND(a.precio*b.cantidad)) AS suma FROM producto AS a INNER JOIN factura_detalle AS b ON a.id = b.producto_id INNER JOIN factura AS c ON c.id = b.factura_id INNER JOIN cliente AS d ON c.cliente_id = d.id GROUP BY (d.id) ORDER BY suma");
        cs.execute();
        rs = cs.getResultSet();

        while (rs.next())
            System.out.println("PRODUCTO " + rs.getString(1) + " TOTAL " + rs.getInt(2));

        //QUERY3
        cs = c.prepareCall("SELECT moneda.nombre, count(*) AS contador FROM moneda INNER JOIN factura ON moneda.id = factura.moneda_id GROUP BY (moneda.id) ORDER BY contador DESC");
        cs.execute();
        rs = cs.getResultSet();

        while (rs.next())
            System.out.println("MONEDA " + rs.getString(1) + " TOTAL " + rs.getInt(2));

//        QUERY4
        cs = c.prepareCall("SELECT producto.nombre, count(*) FROM producto INNER JOIN proveedor ON producto.proveedor_id = proveedor.id GROUP BY(producto.nombre)");
        cs.execute();
        rs = cs.getResultSet();

        while (rs.next())
            System.out.println("PRODUCTO " + rs.getString(1) + " TOTAL " + rs.getInt(2));


        //QUERY5
        cs = c.prepareCall("SELECT producto.nombre, SUM(ROUND(factura_detalle.cantidad)) AS suma FROM producto INNER JOIN factura_detalle ON producto.id = factura_detalle.producto_id GROUP BY(producto.nombre) ORDER BY suma DESC");
        cs.execute();
        rs = cs.getResultSet();

        while (rs.next())
            System.out.println("PRODUCTO " + rs.getString(1) + " TOTAL " + rs.getInt(2));

        //QUERY6
        cs = c.prepareCall("SELECT producto.nombre, SUM(ROUND(factura_detalle.cantidad)) AS suma FROM producto INNER JOIN factura_detalle ON producto.id = factura_detalle.producto_id GROUP BY(producto.nombre) ORDER BY suma ASC");
        cs.execute();
        rs = cs.getResultSet();

        while (rs.next())
            System.out.println("PRODUCTO MENOS VENDIDO " + rs.getString(1) + " TOTAL " + rs.getInt(2));

        //QUERY7
        cs = c.prepareCall("SELECT factura.fecha_emision, cliente.nombre, cliente.apellido, producto.nombre , factura_detalle.cantidad, factura_tipo.nombre FROM cliente INNER JOIN factura ON cliente.id = factura.cliente_id INNER JOIN factura_detalle ON factura.id = factura_detalle.factura_id INNER JOIN producto ON factura_detalle.producto_id = producto.id INNER JOIN factura_tipo ON factura_tipo.id = factura.factura_tipo_id");
        cs.execute();
        rs = cs.getResultSet();

        while (rs.next())
            System.out.println("FECHA_EMISION " + rs.getDate(1) + " NOMBRE " + rs.getString(2) + " APELLIDO " + rs.getString(3) + " PRODUCTO " + rs.getString(4) + " CANTIDAD " +  rs.getInt(5) + " FACTURA TIPO " + rs.getString(6));

        cs = c.prepareCall("SELECT c.id, SUM(ROUND(a.precio*b.cantidad/11)) AS suma FROM producto AS a INNER JOIN factura_detalle AS b ON a.id = b.producto_id INNER JOIN factura AS c ON c.id = b.factura_id GROUP BY (c.id) ORDER BY suma DESC");
        cs.execute();
        rs = cs.getResultSet();

        while (rs.next())
            System.out.println("ID FACTURA " + rs.getInt(1) + " PRODUCTO SIN IVA " + rs.getInt(2));

        cs = c.prepareCall("SELECT c.id, SUM(ROUND(a.precio*b.cantidad)) AS suma FROM producto AS a INNER JOIN factura_detalle AS b ON a.id = b.producto_id INNER JOIN factura AS c ON c.id = b.factura_id GROUP BY (c.id) ORDER BY suma DESC");
        cs.execute();
        rs = cs.getResultSet();
        while (rs.next())
            System.out.println("ID FACTURA " + rs.getInt(1) + " PRODUCTO SIN IVA " + rs.getInt(2));

    }
}
