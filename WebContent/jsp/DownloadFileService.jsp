<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><%@page
	language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<% 	
	ArrayList<File> sharedFileList = new ArrayList<File>();

	String sharedDirPath = this.getServletContext().getInitParameter("shared.dir");
	if( (sharedDirPath!=null) && (!sharedDirPath.trim().equals("")) ){
		
		File sharedDir = new File( sharedDirPath );
		if( sharedDir.exists() && sharedDir.isDirectory() ){
		
			File[] sharedFiles = sharedDir.listFiles();
			if( sharedFiles!=null ){
				
				session.setAttribute("sharedDirPath", sharedDirPath);
			
				for( int i=0; i<sharedFiles.length; i++ ){
					if( sharedFiles[i].isFile() && (!sharedFiles[i].isHidden()) ){
						sharedFileList.add(sharedFiles[i]);
					}				
				}
			}
		}
	}
%>
<html>
<head>
<title>Shared Files</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
<%
	String serverContextPath = request.getContextPath();
	Iterator<File> sharedFileListIt = sharedFileList.iterator();
	File sharedFile = null;
	double fileSizeMb = 0;
	DecimalFormat df = new DecimalFormat("#.00");
	while( sharedFileListIt.hasNext()  ){
		sharedFile = sharedFileListIt.next();
		fileSizeMb = (sharedFile.length()/1024D)/1024D;
 %>
 <div style="float: left; width: 30%;"><p><a href="<%=serverContextPath %>/download?file=<%=sharedFile.getName() %>" target="frameToDownload"><%=sharedFile.getName() %> (<%=df.format(fileSizeMb) %> Mb)</a></p></div>
 <%
 	}
  %>
<iframe id="frameToDownload" name="frameToDownload" height="0" width="0"></iframe>
</body>
</html>