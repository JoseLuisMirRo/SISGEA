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
    <style>
        #date-input {
            border: none;
            outline: none;
            padding: 5px 10px;
        }
    </style>
    <!--FullCalendar SCRIPT-->
    <script src='${pageContext.request.contextPath}/assets/js/fullcalendar-6-1-15/index.global.min.js'></script>
    <!--Resources script-->
    <script src="${pageContext.request.contextPath}/assets/js/fullCalendar/generateResources.js"></script>
    <script>

        document.addEventListener('DOMContentLoaded', async function () {
            const loadingAnimation = document.getElementById('loading-animation');
            loadingAnimation.style.display = 'block';
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
                    left: 'prev,next today datepickerButton',
                    center: 'title',
                    right: 'resourceTimeGridDay,resourceTimeline'
                },
                customButtons: {
                    datepickerButton: {
                        text: 'Buscar por fecha',
                        click: function () {
                            const dateModal = new bootstrap.Modal(document.getElementById('dateModal'));
                            dateModal.show();
                        }
                    }
                },
                selectable: false,
                editable: false,
                height: 'auto',
                slotDuration: '00:20:00',
                dayMinWidth: 200,
                nowIndicator: true,
                slotMinTime: "07:00:00",
                slotMaxTime: "22:00:00",
                droppable: false,
                hiddenDays: [7]

            });
            loadingAnimation.style.display = 'none';
            calendar.render();
            const dateInput = document.getElementById('date-input');
            dateInput.addEventListener('change', function () {
                const selectedDate = dateInput.value;
                if(selectedDate){
                    calendar.gotoDate(selectedDate);
                    const dateModal = bootstrap.Modal.getInstance(document.getElementById('dateModal'));
                    dateModal.hide();
                }
            });

            // Cerrar el dropdown si se hace clic fuera de él
            document.addEventListener('click', function(event) {
                const datepickerButton = document.querySelector('.fc-datepickerButton-button');
                const dateDropdown = document.getElementById('date-dropdown');
                if (!datepickerButton.contains(event.target) && !dateDropdown.contains(event.target)) {
                    dateDropdown.classList.remove('show');
                }
            });
        });

    </script>
</head>
<body>
<br>
<div class="main-container">
    <div id="loading-animation" style="display: none; text-align: center;">
        <img src="${pageContext.request.contextPath}/assets/img/preloader.gif" alt="Cargando..." />
    </div>
    <div id='calendar'></div>
</div>
<div class="modal fade" id="dateModal" tabindex="-1" aria-labelledby="dateModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="dateModalLabel">Selecciona una fecha</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="date" id="date-input" class="form-control">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>