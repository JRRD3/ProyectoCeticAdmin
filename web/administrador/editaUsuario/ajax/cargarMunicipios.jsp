<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    List<String> Mun = new ArrayList<String>();
    List<String> noMun = new ArrayList<String>();
    ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
    String bd = resource.getString("ceticAdmin.bd_name");
    String usr = resource.getString("ceticAdmin.bd_user");
    String pssw = resource.getString("ceticAdmin.bd_password");
    String usrEmp = resource.getString("ceticAdmin.bd_userEmp");
    String psswEmp = resource.getString("ceticAdmin.bd_passwordEmp");
    String estado = request.getParameter("selected");
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM cat_municipios WHERE claveEntidad = "+estado+" ORDER BY descripcionMunicipio");
        while(rs.next()){
//            System.out.println(rs.getString("descripcionMunicipio")); 
            Mun.add(rs.getString("descripcionMunicipio"));
            noMun.add(rs.getString("id_cat_municipios"));
        }
        conexion.close();
    }catch(Exception e){System.out.println(e);}

    String Municipio = "";
    for(String Muni : Mun)
        Municipio = Municipio+"\""+Muni+"\""+",";
    Municipio = Municipio.substring(0,Municipio.length()-1);
    
    String noMunicipio = "";
    for(String Muni : noMun)
        noMunicipio = noMunicipio+"\""+Muni+"\""+",";
    noMunicipio = noMunicipio.substring(0,noMunicipio.length()-1);
%>
{
"descripcionMunicipio":[<%=Municipio%>],
"id_cat_municipios":[<%=noMunicipio%>],
"TotMun":"<%=Mun.size()%>"
}