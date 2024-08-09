<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 09/07/2024
  Time: 10:56 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FullCalendar</title>
    <!--FullCalendar SCRIPT-->
    <script src='${pageContext.request.contextPath}/assets/js/fullcalendar-6-1-15/index.global.min.js'></script>
    <!--Resources script-->
    <script src="${pageContext.request.contextPath}/assets/js/fullCalendar/generateResources.js"></script>
    <script>

        document.addEventListener('DOMContentLoaded', async function () {
            const roomResources = await fetchRooms();
            const [reserveResources, scheduleResources, nbdResources] = await Promise.all([
                fetchReserves(),
                fetchSchedules(),
                fetchNonBusinessDays()
            ]);

            const eventResources = roomResources.concat(reserveResources, scheduleResources, nbdResources);

            const calendarEl = document.getElementById('calendar');
            const calendar = new FullCalendar.Calendar(calendarEl, {
                schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives', //Licencia Creative Commons
                timezone: 'GMT -5',
                locale: 'es',
                initialView: 'resourceTimeGrid',
                contentHeight: 'auto',
                themeSystem: 'bootstrap5',
                resources: roomResources,
                events: eventResources,
                slotLabelFormat: [
                    {
                        hour: 'numeric',
                        minute: '2-digit',
                        omitZeroMinute: false,
                        meridiem: 'short'
                    }
                ],
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'resourceTimeGridDay,resourceTimeline'
                },
                selectable: false,
                editable: false,
                nowIndicator: true,
                slotMinTime: "07:00:00",
                slotMaxTime: "22:00:00",
                droppable: false,
                hiddenDays: [7]


            });
            calendar.render();
        });

    </script>
</head>
<body>
<br>
<div id='calendar'></div>
</body>
</html>