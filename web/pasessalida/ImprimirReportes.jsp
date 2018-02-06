
<!--librerias para iText-->
<%@page import="com.itextpdf.text.pdf.PdfCopy"%>
<%@page import="com.lowagie.text.pdf.PdfReader"%>
<%@page import="com.lowagie.text.pdf.PdfCopyFields"%>
<!--Aquí termina-->

<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    System.out.println("Entre");
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
    String[] selectNames = request.getParameterValues("selectNames");
    String tipoContrato = request.getParameter("tipoContrato");
    String rol = request.getParameter("rol");

    if (nombres == null) {
        nombres = "null";
    }
    if (rol == null) {
        rol = "2";
    } else if(rol.equalsIgnoreCase("1")) {
        //Consulta del nombre de usuario (username) del empleado que el administrador ha elegido.
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

    } else if (matriz == null && ps == null && tipoContrato != null && !tipoContrato.equalsIgnoreCase("[Null, Null]")) {
            
        
        palabra = "'";
        for (int i = 0; i < tipoContrato.length(); i++) {
            char caracter = tipoContrato.charAt(i);

            if (caracter != 91 && caracter != 93 && caracter != 44 && caracter != 32) {
                palabra = palabra + caracter;
            }
            if (caracter == 44) {
                palabra = palabra + "', '";
            }
            if (caracter == 93) {
                palabra = palabra + "'";
            }
        }
        

        ArrayList  pasar = new ArrayList();
        if (selectNames == null || !selectNames.equals(""+"")) {
            System.out.println("es nulo");
            //Consulta del nombre completo de todos los empleados, filtrado por el tipo de contrato ya establecido anteriormente por el administrador.
            String consulta = "select concat(primerApellido,' ', segundoApellido, ' ',nombres) as nombre from cat_empleados where activo= '1' and contrato in ( "+palabra+") order by primerApellido;";
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                Statement stmt = conexion.createStatement();
                ResultSet hh = stmt.executeQuery(consulta);
                while (hh.next()) {
                    pasar.add(hh.getString("nombre"));
                }
            } catch (Exception e) {
                System.out.println(e);
            }
            
            selectNames = new String [pasar.size()];
            for(int i = 0; i < pasar.size(); i++){
              selectNames[i] = ""+pasar.get(i);
            }
        }else{
            System.out.println("no es nulo");
        }

        //    para concatenar los pdfs
        String archivo2 = application.getRealPath("/pasessalida/reportes/resultado.pdf");
        PdfCopyFields copy = new PdfCopyFields(new FileOutputStream(archivo2));
        String archivo = "";
//       Aquí termina
        
        int verificar = 0; // sirve para saber si el empleado ha faltado o llegado tarde o salio antes de tiempo.
            for (int i = 0; i < selectNames.length; i++) {
            verificar = 0;
            String ccc = "select tipo from asistencias inner join cat_empleados where '"+ selectNames[i] +"' = concat(primerApellido,' ', segundoApellido, ' ',nombres) and cat_empleados.idcat_empleados = asistencias.idnominaemp and asistencias.tipo in ('r','f', 'ex' );";
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                Statement stmt = conexion.createStatement();
                ResultSet hh = stmt.executeQuery(ccc);
                while (hh.next()) {
                    verificar = 1;
                    break;
                }
            } catch (Exception e) {
                System.out.println(e);
            }    
            
            if(verificar == 1){
                
            archivo = application.getRealPath("/pasessalida/reportes/memorandum_" + i + ".pdf");
            nombres = selectNames[i];

            int numero = 0;
            String faltas = "0";
            int numero2 = 0;
            String retardos = "0";
            int numero3 = 0;
            String extraordinarias = "0";
            String limite = null;

            int dia = 0;
            Date ahora = new Date();
            GregorianCalendar cal = new GregorianCalendar();
            cal.setTime(ahora);
            dia = cal.get(Calendar.DAY_OF_WEEK); // Domingo = 1, Lunes = 2, Martes = 3, Miercoles = 4, Jueves = 5, Viernes = 6 , Sabado = 7.        

            if (dia == 7) {
                dia = 9;
            } else if (dia == 1) {
                dia = 8;
            } else {
                dia = 7;
            }

            SimpleDateFormat form = new SimpleDateFormat("dd");
            SimpleDateFormat formateador = new SimpleDateFormat("'de'   MMMMM");
            Calendar cale = Calendar.getInstance();
            cale.setTimeZone(TimeZone.getDefault());
            int dd = Integer.parseInt(form.format(new Date()));
            dd = dia + dd;
            if (dd > 30) {
                dd = dd - 30;
            }

            limite = dd + " " + formateador.format(new Date());
            //Consulta el tipo de asistencia y día que tiene el empleado elegido por el administrador, filtrado por el tipo de asistencia.
            String consulta = "select day(fecha), tipo from asistencias inner join cat_empleados where asistencias.tipo in ('F') and '" + nombres + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres) and idnominaemp = idcat_empleados;";
            //Consulta el tipo de asistencia y día que tiene el empleado elegido por el administrador, filtrado por el tipo de asistencia.
            String consulta1 = "select day(fecha), tipo from asistencias inner join cat_empleados where asistencias.tipo in ('R') and '" + nombres + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres) and idnominaemp = idcat_empleados;";
            //Consulta el tipo de asistencia y día que tiene el empleado elegido por el administrador, filtrado por el tipo de asistencia.
            String consulta2 = "select day(fecha), tipo from asistencias inner join cat_empleados where asistencias.tipo in ('EX') and '" + nombres + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres) and idnominaemp = idcat_empleados;";
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
                        } else if (faltas != null) {
                            faltas = faltas + " y " + hh.getString("day(fecha)");
                        }
                    } else if (faltas.equalsIgnoreCase("0")) {
                        faltas = hh.getString("day(fecha)");
                    } else {
                        faltas = faltas + ", " + hh.getString("day(fecha)");
                    }
                }

                hh = stmt.executeQuery(consulta1);
                while (hh.next()) {

                    numero2 = numero2 + 1;
                    if (hh.isLast()) {
                        if (retardos.equalsIgnoreCase("0")) {
                            retardos = hh.getString("day(fecha)");
                        } else if (retardos != null) {
                            retardos = retardos + " y " + hh.getString("day(fecha)");
                        }
                    } else if (retardos.equalsIgnoreCase("0")) {
                        retardos = hh.getString("day(fecha)");
                    } else {
                        retardos = retardos + ", " + hh.getString("day(fecha)");
                    }
                }

                hh = stmt.executeQuery(consulta2);
                while (hh.next()) {

                    numero3 = numero3 + 1;
                    if (hh.isLast()) {
                        if (extraordinarias.equalsIgnoreCase("0")) {
                            extraordinarias = hh.getString("day(fecha)");
                        } else if (extraordinarias != null) {
                            extraordinarias = extraordinarias + " y " + hh.getString("day(fecha)");
                        }
                    } else if (extraordinarias.equalsIgnoreCase("0")) {
                        extraordinarias = hh.getString("day(fecha)");
                    } else {
                        extraordinarias = extraordinarias + ", " + hh.getString("day(fecha)");
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.print(e.toString());
            }

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
                parameters.put("numero3", numero3);
                parameters.put("extraordinarias", extraordinarias);
                parameters.put("limite", limite);

                JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, connection);

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

            PdfReader reader1 = new PdfReader(archivo);
            copy.addDocument(reader1);
            reader1.close();
            
            }

        }
            copy.close();

            File pdfFile = new File(application.getRealPath("/pasessalida/reportes/resultado.pdf"));
            byte[] pdfByteArray = FileUtils.readFileToByteArray(pdfFile);
            response.setContentType("application/pdf");
            response.setHeader("Content-Length", String.valueOf(pdfFile.length()));
            response.setHeader("Content-Disposition", "inline; filename=\"" + pdfFile.getName() + "\"");
            response.getOutputStream().write(pdfByteArray);
            response.getOutputStream().flush();
    } else {%>
<br><br>


<h1 style="  position:absolute; left:32%; color: red;"> POR FAVOR SELECCIONE ALGÚN TIPO DE CONTRATO</h1>  
<% }
%>  