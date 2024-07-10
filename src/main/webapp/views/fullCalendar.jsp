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
    <!--BootStrap-->
    <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet'>
    <!--BootStrap-->
    <link href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css' rel='stylesheet'>
    <link rel="stylesheet" href="styles.css" />
    <!--FullCalendar SCRIPT-->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.14/index.global.min.js'></script>
    <script>

        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives', //Licencia Creative Commons
                timezone: 'GMT -5',
                locale: 'es',
                initialView: 'resourceTimeGrid',
                contentHeight: 'auto',
                themeSystem: 'bootstrap5',
                resources: [
                    { id: 'D1A1', title: 'A1', eventColor: 'green'},
                    { id: 'D1A2', title: 'A2', eventColor: 'blue'},
                    { id: 'D1A3', title: 'A3', eventColor: 'red'},
                    { id: 'D1A4', title: 'A4', eventColor: 'yellow'},
                    { id: 'D1A5', title: 'A5', eventColor: 'green'},
                    { id: 'D1A6', title: 'A6', eventColor: 'green'},
                    { id: 'D1A7', title: 'A7', eventColor: 'green'},
                    { id: 'D1A8', title: 'A8', eventColor: 'green'},
                    { id: 'D1A9', title: 'A9', eventColor: 'green'},
                    { id: 'D2CC7', title: 'CC7', eventColor: 'blue'}
                ],
                events: [
                    { id: '1', resourceId: 'D1A1', start: '2024-06-10T14:00:00', end: '2024-06-10T16:00:00', title: 'Aplicaciones Web' },
                    {id: '2', resourceId: 'D2CC7', start: '2024-06-10T12:00:00', end: '2024-06-10T14:00:00', title: 'Sistemas Operativos'},

                ],
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
                selectable: true,
                editable: true,
                nowIndicator: true,
                slotMinTime: "09:00:00",
                slotMaxTime: "22:00:00",
                droppable: true,
                hiddenDays: [7]


            });
            calendar.render();
        });

    </script>
</head>
<body>
<div id='calendar'></div>
</body>
</html>