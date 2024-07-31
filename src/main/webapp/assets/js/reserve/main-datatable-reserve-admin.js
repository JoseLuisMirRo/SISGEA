let dataTable;
let dataTableInitiated=false;

const dataTableOptions= {
    //scrollX: "2000px"
    lengthMenu: [5, 10, 25],
    scrollX: true,
    columnDefs: [
        {className: "text-center", targets: [0, 1, 2, 3, 4, 5, 6, 7]},
        {orderable: false, targets: [6, 7]},
        {searchable: false, targets: [6, 7]},
        {width: "", targets: []}
    ],
    pageLength: 10,
    language: {
        url: 'https://cdn.datatables.net/plug-ins/2.0.8/i18n/es-ES.json'
    },
};

const initDataTable=async()=>{
    if(dataTableInitiated){
        dataTable.destroy();
        destroy=true;
    }

    await listReserves();

    dataTable=$('#datatable_reserves').DataTable(dataTableOptions);

    dataTableInitiated=true;
};



const listReserves=async(showAll = false)=>{
    try{
        const response=await fetch('http://localhost:8080/SISGEA_war_exploded/data/reserves');
        const reserves=await response.json();

        let content= ``;
        const currentDate = new Date().toISOString().split('T')[0];

        reserves.forEach((rse,index) => {
            const startTime = deleteSeconds(rse.startTime);
            const endTime = deleteSeconds(rse.endTime);
            const isPast = isPastDateTime(manageDate(rse.date), hourTo24(rse.startTime));
            if(!showAll && manageDate(rse.date) < currentDate){
                return;
            }
            content+=`
            <tr>
                <td>${rse.user.firstName} ${rse.user.lastNameP} ${rse.user.lastNameM}</td>
                <td>${rse.description}</td>
                <td>${rse.room.roomType.abbreviation}${rse.room.number}${rse.room.building.abbreviation}</td>
                <td>${rse.date}</td>
                <td>${startTime}</td>
                <td>${endTime}</td>
                <td>
                    <i class="${rse.status === 'Active' ? 'bi bi-check-circle' :
                                rse.status === 'Canceled' ? 'bi bi-x-circle' :
                                rse.status === 'Admin_Canceled' ? 'bi bi-x-octagon' : ''}" 
                        style="color: ${rse.status === 'Active' ? 'green' :
                                        rse.status === 'Canceled' ? 'red' :
                                        rse.status === 'Admin_Canceled' ? 'orange' : 'black'};"
                        data-bs-toggle="tooltip" data-bs-placement="top"
                        data-bs-title="${rse.status === 'Active' ? 'Activa' :
                                         rse.status === 'Canceled' ? 'Cancelada por usuario' :
                                         rse.status === 'Admin_Canceled' ? 'Cancelada por un Administrador - Verifique su email para más detalles' : 'Desconocido'}">
                    </i>
                </td>
                <td>
                    <button class="btn ${isPast ? 'btn-outline-secondary' : 'btn-primary'} btn-sm edit-btn" 
                    data-id="${rse.id}"
                    data-roomid="${rse.room.id}"
                    data-date="${rse.date}" //CUIDADO: NO USAR MAYUSCULAS EN DATA
                    data-description="${rse.description}"
                    data-startime="${rse.startTime}"
                    data-endtime="${rse.endTime}"
                    data-past="${isPast}"
                    ${isPast ? 'disabled' : ''}
                    ><i class="bi bi-pencil-square"></i></button>
                    
                    <button class="${rse.status === 'Active' ? (isPast ? 'btn btn-outline-secondary btn-sm delete-btn' : 'btn btn-danger btn-sm delete-btn') :
                    rse.status === 'Canceled' ? (isPast ? 'btn btn-outline-secondary btn-sm enable-btn' : 'btn btn-success btn-sm enable-btn') :
                    rse.status === 'Admin_Canceled' ? (isPast ? 'btn btn-outline-secondary btn-sm enable-btn' : 'btn btn-success btn-sm enable-btn') : ''}"
                    data-id="${rse.id}"
                    data-past="${isPast}"
                    ${isPast ? 'disabled' : ''}
                    ><i class="${rse.status === 'Active' ? 'bi bi-trash3-fill' :
                    rse.status === 'Canceled' ? 'bi bi-check-square-fill' :
                    rse.status === 'Admin_Canceled' ? 'bi bi-check-square-fill' : ''}"></i></button>
                </td>
            </tr>`;
        });

        tableBody_reserves.innerHTML=content;
        const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
        const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

    }catch(ex){
        alert(ex);
    }
};
const isPastDateTime = (date, time) => {
    const reserveDateTime = new Date(`${date}T${time}`);
    const currentDateTime = new Date();
    return reserveDateTime < currentDateTime;
};

window.addEventListener('load',async()=>{
    await initDataTable();
    await listReserves(false);
    document.getElementById('historyBtn').setAttribute('data-showAll', false);
});

function deleteSeconds(timeS) {
    const parts = timeS.split(' '); //DIVIDIMOS POR ESPACIOS PARA SEPARAR AM Y PM
    const time = parts[0] //OBTENEMOS LA PARTE SOLO CON LA HORA
    const period = parts[1] //OBTENEMOS LA PARTE SOLO CON AM Y PM

    const [hour, minute] = time.split(':'); //DIVIDIMOS HORAS Y MINUTOS - SEGUNDOS SE DESPRECIAN
    return `${hour}:${minute} ${period}`;
}

$(document).ready(function () {
    $('#datatable_reserves').on('click', '.edit-btn', function () {
        const id = $(this).data('id');
        const roomId = $(this).data('roomid');
        const date = $(this).data('date');
        const description = $(this).data('description');
        const startTime = $(this).data('startime');
        const endTime = $(this).data('endtime');

        $('#reserveUpdateModal').attr('data-id', id);
        $('#reserveUpdateModal').attr('data-roomid', roomId);
        $('#reserveUpdateModal').attr('data-date', date);
        $('#reserveUpdateModal').attr('data-description', description);
        $('#reserveUpdateModal').attr('data-starttime', startTime);
        $('#reserveUpdateModal').attr('data-endtime', endTime);

        $('#reserveUpdateModal').modal('show');
    });

    $('#datatable_reserves').on('click', '.delete-btn', function () {
        const isPast = $(this).data('past');
        if (isPast) {
            return;
        }
        const id = $(this).data('id');
        $('#cancelReserveId').val(id);
        $('#reserveCancelModal').modal('show');
    });

    $('#datatable_reserves').on('click', '.enable-btn', function () {
        const isPast = $(this).data('past');
        if (isPast) {
            return;
        }
        const id = $(this).data('id');
        $('#reactivateReserveId').val(id);
        $('#reactivateReserveModal').modal('show');
    });

});
document.getElementById('historyBtn').addEventListener('click',async()=>{
    const button = document.getElementById('historyBtn');
    const showAll = button.getAttribute('data-showAll') === 'true';

    await listReserves(!showAll);
    button.setAttribute('data-showAll', !showAll);
    button.textContent = !showAll ? 'Ver reservas vigentes' : 'Ver historial completo';
});



