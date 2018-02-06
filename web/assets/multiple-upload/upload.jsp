<%@page import="java.util.ResourceBundle"%><%@page import="java.sql.Connection"%><%@page import="java.sql.ResultSet"%><%@page import="java.sql.DriverManager"%><%@page import="java.sql.Statement"%><%@page import="java.util.Date"%><%@page import="java.text.SimpleDateFormat"%><%@page import="java.io.File"%><%@page import="org.apache.commons.fileupload.FileItem"%><%@page import="java.util.Iterator"%><%@page import="java.util.List"%><%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%><%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%><%@page import="org.apache.commons.fileupload.FileItemFactory"%><%@page contentType="text/simple" %>
<%
    ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
    String bd = resource.getString("ceticAdmin.bd_name");
    String usr = resource.getString("ceticAdmin.bd_user");
    String pssw = resource.getString("ceticAdmin.bd_password");
    
    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    List uploadedItems = null;
    FileItem fileItem = null;

//    String filePath = "application.getRealPath("\\adjuntos\\")+"\\"+";
    String idViatico = request.getParameter("idViatico");
    String idEmpleado = request.getParameter("idEmpleado");
    String tipo = request.getParameter("tipo");
    File carpeta = new File(application.getRealPath("\\adjuntos\\")+"\\"+idViatico+"\\");
    if(!carpeta.exists()) carpeta.mkdir();
    String filePath = application.getRealPath("\\adjuntos\\")+"\\"+idViatico+"\\";
    String archivo = "";
    uploadedItems = upload.parseRequest(request);
    Iterator i = uploadedItems.iterator();
    while (i.hasNext()) {
        fileItem = (FileItem) i.next();
        if (fileItem.isFormField() == false) {
            if (fileItem.getSize() > 0) {
                File uploadedFile = null;
                String myFullFileName = fileItem.getName(),
                        myFileName = "", slashType
                        = (myFullFileName.lastIndexOf("\\") > 0) ? "\\" : "/";
                int startIndex = myFullFileName.lastIndexOf(slashType);
                myFileName = myFullFileName.substring(startIndex
                        + 1, myFullFileName.length());
                
                String nombreArchivo = myFileName.substring(0,myFileName.lastIndexOf("."));
                String extArchivo = myFileName.substring(myFileName.lastIndexOf(".") +1);
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy.HH-mm-ss");
                String str = dateFormat.format(new Date());
                myFileName = nombreArchivo+","+str+"."+extArchivo;
//                System.out.println(myFileName);
                
                uploadedFile = new File(filePath, myFileName);   
//                uploadedFile = new File(filePath, "Archivo");
                request.setAttribute("myFileName", myFileName);
                fileItem.write(uploadedFile);
                
                archivo = myFileName;
            }
        }
    }
    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
    String strFecha = fmt.format(new Date());
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        stmt.executeUpdate("INSERT INTO cat_adjuntos (idViatico,idEmpleado,nombreArchivo,fechaAdjunto,tipo) "
                          +"VALUES ("+idViatico+","+idEmpleado+",'"+archivo+"','"+strFecha+"','"+tipo+"')");
        conexion.close();
    }catch(Exception e){System.out.println(e);}
    
%>["${myFileName}"]

