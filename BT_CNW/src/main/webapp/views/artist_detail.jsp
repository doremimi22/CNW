<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>${artist.name}</h2>
<p>${artist.biography}</p>

<h3>Bài hát của nghệ sĩ</h3>
<ul>
    <c:forEach var="s" items="${songs}">
        <li>${s.title} - năm ${s.year}</li>
    </c:forEach>
</ul>

<h3>Album có bài hát của nghệ sĩ</h3>
<ul>
    <c:forEach var="al" items="${albums}">
        <li>${al.title} (${al.releaseYear})</li>
    </c:forEach>
</ul>
