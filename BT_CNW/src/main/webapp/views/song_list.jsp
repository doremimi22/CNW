<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>Danh sách bài hát</h2>

<ul>
    <c:forEach var="s" items="${songs}">
        <li>
            ID: ${s.songId} - ${s.title}
            <a href="song?action=detail&id=${s.songId}">Chi tiết</a>
        </li>
    </c:forEach>
</ul>
