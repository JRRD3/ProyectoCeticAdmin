<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="java.io.File"%>
<%@page import="net.sf.jasperreports.engine.JRExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JRExporter"%>
<%@page import="net.sf.jasperreports.engine.export.JRPdfExporter"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="org.apache.tomcat.util.codec.binary.Base64"%>

<%
    String palabra = "";
    String ps = request.getParameter("ids");
    String matriz = request.getParameter("matriz");

    String User = SecurityContextHolder.getContext().getAuthentication().getName();
    ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
    String bd = resource.getString("ceticAdmin.bd_nameNomina");
    String usr = resource.getString("ceticAdmin.bd_user");
    String pssw = resource.getString("ceticAdmin.bd_password");
    String bdadmin = resource.getString("ceticAdmin.bd_name");

    String nombres = request.getParameter("nombres");
    String rol = request.getParameter("rol");

    if (nombres == null) {
        nombres = "null";
    }
    if (rol == null) {
        rol = "2";
    } else {

        String consulta = "select username from usuario inner join cat_empleados where (usuario.rfc = cat_empleados.rfc and '" + nombres + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres));";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexion = DriverManager.getConnection(bd, usr, pssw);
            Statement stmt = conexion.createStatement();
            ResultSet hh = stmt.executeQuery(consulta);
            while (hh.next()) {
                nombres = hh.getString("username");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    if (ps != null) {

        for (int i = 0; i < ps.length(); i++) {
            char caracter = ps.charAt(i);
            if (caracter != 91 && caracter != 93) {
                palabra = palabra + caracter;
            }
        }

        try {
            String rutaPlantilla = application.getRealPath("/pasessalida/reportes/primero.jasper");
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(new File(rutaPlantilla));
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(bd, usr, pssw);
            Map parameters = new HashMap();

            //Parametros
            parameters.put("id_pase", palabra);
            if (rol.equalsIgnoreCase("1")) {
                parameters.put("usuario", nombres);
            } else {
                parameters.put("usuario", User);
            }

            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, connection);

            String archivo = application.getRealPath("/pasessalida/reportes/permiso.pdf");
            OutputStream os = new FileOutputStream(new File(archivo));

            JRExporter exporter = new JRPdfExporter();
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
            exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, os);
            exporter.exportReport();
            os.close();

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.print("El error del reporte es: " + e.toString());
        }

        File pdfFile = new File(application.getRealPath("/pasessalida/reportes/permiso.pdf"));
        byte[] pdfByteArray = FileUtils.readFileToByteArray(pdfFile);
        response.setContentType("application/pdf");
        response.setHeader("Content-Length", String.valueOf(pdfFile.length()));
        response.setHeader("Content-Disposition", "inline; filename=\"" + pdfFile.getName() + "\"");
        response.getOutputStream().write(pdfByteArray);
        response.getOutputStream().flush();

    } else if (matriz != null) {
        palabra = "'";
        for (int i = 0; i < matriz.length(); i++) {
            char caracter = matriz.charAt(i);

            if (caracter != 91 && caracter != 93 && caracter != 44) {
                palabra = palabra + caracter;
            }
            if (caracter == 44) {
                palabra = palabra + "', '";
            }
            if (caracter == 93) {
                palabra = palabra + "'";
            }
        }
//        out.print(palabra);
        try {
            String rutaPlantilla = application.getRealPath("/pasessalida/reportes/Asistencia.jasper");
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(new File(rutaPlantilla));
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(bd, usr, pssw);
            Map parameters = new HashMap();

            //Parametros
            parameters.put("fecha", palabra);
            if (rol.equalsIgnoreCase("1")) {
                parameters.put("usuario", nombres);
            } else {
                parameters.put("usuario", User);
            }

            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, connection);

            String archivo = application.getRealPath("/pasessalida/reportes/Asistencia.pdf");
            OutputStream os = new FileOutputStream(new File(archivo));

            JRExporter exporter = new JRPdfExporter();
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
            exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, os);
            exporter.exportReport();
            os.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.print("El error del reporte es: " + e.toString());
        }
        File pdfFile = new File(application.getRealPath("/pasessalida/reportes/Asistencia.pdf"));
        byte[] pdfByteArray = FileUtils.readFileToByteArray(pdfFile);
        response.setContentType("application/pdf");
        response.setHeader("Content-Length", String.valueOf(pdfFile.length()));
        response.setHeader("Content-Disposition", "inline; filename=\"" + pdfFile.getName() + "\"");
        response.getOutputStream().write(pdfByteArray);
        response.getOutputStream().flush();

    } else if (matriz == null && ps == null && nombres != null) {

        int numero = 0;
        String faltas = "0";
        int numero2 = 0;
        String retardos = "0";
        int total = 0;
        String consulta = "select day(fecha) from asistencias inner join cat_empleados where asistencias.tipo = 'F' and '" + nombres + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres) and idnominaemp = idcat_empleados;";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexion = DriverManager.getConnection(bd, usr, pssw);
            Statement stmt = conexion.createStatement();
            ResultSet hh = stmt.executeQuery(consulta);
            while (hh.next()) {
                numero = numero + 1;
                if (hh.isLast()) {
                    if (faltas.equalsIgnoreCase("0")) {
                        faltas = hh.getString("day(fecha)");
                    } else {
                        faltas = faltas + " y " + hh.getString("day(fecha)");
                    }
                } else if (faltas.equalsIgnoreCase("0")) {
                    faltas =hh.getString("day(fecha)");
                } else {
                    faltas = faltas + ", " + hh.getString("day(fecha)");
                }
            }
            
            consulta = "select day(fecha) from asistencias inner join cat_empleados where asistencias.tipo = 'R' and '" + nombres + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres) and idnominaemp = idcat_empleados;";
            ResultSet retar = stmt.executeQuery(consulta);
            while (retar.next()) {
                numero2 = numero2 + 1;
                if (retar.isLast()) {
                    if (retardos.equalsIgnoreCase("0")) {
                        retardos = retar.getString("day(fecha)");
                    } else {
                        retardos = retardos + " y " + retar.getString("day(fecha)");
                    }
                } else if (retardos.equalsIgnoreCase("0")) {
                    retardos = retar.getString("day(fecha)");
                } else {
                    retardos = retardos + ", " + retar.getString("day(fecha)");
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        
        total = numero + numero2;      

        try {
            String rutaPlantilla = application.getRealPath("/pasessalida/reportes/Memorandum.jasper");
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(new File(rutaPlantilla));
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(bd, usr, pssw);
            Map parameters = new HashMap();

            //Parametros
            parameters.put("usuario", nombres);
            parameters.put("faltas", faltas);
            parameters.put("retardos", retardos);
            parameters.put("numero", numero);
            parameters.put("numero2", numero2);
            parameters.put("total", total);

            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, connection);

            String archivo = application.getRealPath("/pasessalida/reportes/memorandum.pdf");
            OutputStream os = new FileOutputStream(new File(archivo));

            JRExporter exporter = new JRPdfExporter();
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
            exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, os);
            exporter.exportReport();
            os.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.print("El error del reporte es: " + e.toString());
        }
        File pdfFile = new File(application.getRealPath("/pasessalida/reportes/memorandum.pdf"));
        byte[] pdfByteArray = FileUtils.readFileToByteArray(pdfFile);
        response.setContentType("application/pdf");
        response.setHeader("Content-Length", String.valueOf(pdfFile.length()));
        response.setHeader("Content-Disposition", "inline; filename=\"" + pdfFile.getName() + "\"");
        response.getOutputStream().write(pdfByteArray);
        response.getOutputStream().flush();
    }
%>  