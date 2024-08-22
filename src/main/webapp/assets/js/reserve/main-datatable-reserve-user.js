let dataTable;
let dataTableInitiated=false;
const basePath = `${window.location.origin}${window.location.pathname}`;
const lastSlashIndex = basePath.lastIndexOf('/');
const cleanBasePath = basePath.substring(0, lastSlashIndex + 1);

const dataTableOptions={
    //scrollX: "2000px"
    lengthMenu:[5,10,25],
    scrollX: true,
    columnDefs: [
        {className: "text-center",targets:[0,1,2,3,4,5,6]},
        {orderable: false,targets:[5,6]},
        {searchable:false,targets:[5,6]},
        {width:"",targets:[]}
    ],
    pageLength:10,
    language:{
        url:`${cleanBasePath}assets/js/datatables-2-1-3/spanishMX.json`
    }
};

const initDataTable=async(showMode)=>{
    const loadingAnimation = document.getElementById('loading-animation');
    const reserveTable = document.getElementById('reserve-table');

    loadingAnimation.style.display = 'block';
    reserveTable.style.display = 'none';

    if(dataTableInitiated){
        dataTable.destroy();
        destroy=true;
    }

    await listReserves(showMode);

    dataTable=$('#datatable_reserves').DataTable(dataTableOptions);

    dataTableInitiated=true;
    loadingAnimation.style.display = 'none';
    reserveTable.style.display = 'block';
};

const listReserves=async(filterStatus)=>{
    try{
        const response=await fetch(`${cleanBasePath}/data/userReserves?userId=${userId}`);
        const reserves=await response.json();

        let content= ``;
        const currentDate = new Date().toISOString().split('T')[0];

        reserves
            .filter(filterStatus ? rse => rse.date === rse.date: rse => rse.date >= currentDate)
            .forEach((rse,index) => {
            const startTime = deleteSeconds(rse.startTime);
            const endTime = deleteSeconds(rse.endTime);
            const isPast = isPastDateTime((rse.date), hourTo24(rse.startTime));

            content+=`
            <tr>
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
                    data-userid="${rse.user.id}"
                    data-date="${rse.date}"
                    data-description="${rse.description}"
                    data-startime="${rse.startTime}"
                    data-endtime="${rse.endTime}"
                    data-past="${isPast}"
                    ${isPast ? 'disabled' : ''}
                    ><i class="bi bi-pencil-square"></i></button>
                    
                    <button class="btn ${isPast ? 'btn-outline-secondary' :
                            rse.status === 'Active' ? 'bi btn btn-danger btn-sm delete-btn' :
                            rse.status === 'Canceled' ? 'bi btn btn-success btn-sm enable-btn' :
                            rse.status === 'Admin_Canceled' ? 'bi btn btn btn-outline-success btn-sm enable-btn disabled' : ''} btn-sm delete-btn"
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
        const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl, {
            offset: [0, -80] // Ajusta el desplazamiento vertical
        }));

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
    await initDataTable(false);
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
        const isPast = $(this).data('past');
        if (isPast) {
            return;
        }
        const id = $(this).data('id');
        const roomId = $(this).data('roomid');
        const userId = $(this).data('userid');
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
        $('#reserveUpdateModal').attr('data-userid', userId);

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
    const showAll = button.getAttribute('data-showActive') === 'true';
    button.setAttribute('data-showActive', !showAll);
    button.textContent = !showAll ? 'Ver reservas vigentes' : 'Ver historial completo';
    await initDataTable(!showAll);
});

