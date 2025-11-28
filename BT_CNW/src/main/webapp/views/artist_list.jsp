<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>Danh sách Nghệ sĩ</h2>

<ul>
    <c:forEach var="a" items="${artists}">
        <li>
            ID: ${a.artistId}
            - ${a.name}
            - <a href="artist?action=detail&id=${a.artistId}">Xem chi tiết</a>
        </li>
    </c:forEach>
</ul>
