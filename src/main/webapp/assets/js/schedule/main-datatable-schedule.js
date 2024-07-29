let dataTable;
let dataTableInitiated=false;

const dataTableOptions={
    //scrollX: "2000px"
    lengthMenu:[5,10,25],
    scrollX: true,
    columnDefs: [
        {className: "text-center",targets:[0,1,2,3,4,5]},
        {orderable: false,targets:[5]},
        {searchable:false,targets:[5]},
        {width:"",targets:[]}
    ],
    pageLength:10,
    language:{
        url:'https://cdn.datatables.net/plug-ins/2.0.8/i18n/es-ES.json'
    }
};
const initDataTable=async()=>{
    if(dataTableInitiated){
        dataTable.destroy();
        destroy=true;
    }

    await listSchedules();

    dataTable=$('#datatable_schedules').DataTable(dataTableOptions);

    dataTableInitiated=true;
};



const listSchedules=async()=>{
    try{
        const response=await fetch('http://localhost:8080/SISGEA_war_exploded/data/schedules');
        const schedules=await response.json();

        let content= ``;
        schedules.forEach((sch,index) => {
            const startTime = deleteSeconds(sch.startTime);
            const endTime = deleteSeconds(sch.endTime);
            content+=`
            <tr>
                <td>${sch.classe.name}</td>
                <td>${sch.room.roomType.abbreviation}${sch.room.number} - ${sch.room.building.name}</td>
                <td>${sch.day.name}</td>
                <td>${startTime}</td>
                <td>${endTime}</td>
                <td>
                    <button class="btn btn-primary btn-sm edit-btn" 
                    data-id="${sch.id}"
                    data-classid="${sch.classe.id}"
                    data-quarterid="${sch.quarter.id}" //CUIDADO: NO USAR MAYUSCULAS EN DATA
                    data-roomid="${sch.room.id}"
                    data-day="${sch.day.id}"
                    data-startime="${sch.startTime}"
                    data-endtime="${sch.endTime}"
                    ><i class="bi bi-pencil-square"></i></button>
                    
                    <button class="btn btn-danger btn-sm delete-btn"
                    data-id="${sch.id}"
                    ><i class="bi bi-trash3-fill"></i></button>
                </td>
            </tr>`;
        });
        tableBody_schedules.innerHTML=content;

    }catch(ex){
        alert(ex);
    }
};

window.addEventListener('load',async()=>{
    await initDataTable();
});

function deleteSeconds(timeS) {
    const parts = timeS.split(' '); //DIVIDIMOS POR ESPACIOS PARA SEPARAR AM Y PM
    const time = parts[0] //OBTENEMOS LA PARTE SOLO CON LA HORA
    const period = parts[1] //OBTENEMOS LA PARTE SOLO CON AM Y PM

    const [hour, minute] = time.split(':'); //DIVIDIMOS HORAS Y MINUTOS - SEGUNDOS SE DESPRECIAN
    return `${hour}:${minute} ${period}`;
}

//UTILIZANDO JQUERY OBTENEMOS DATOS DE HORARIO CUANDO SE PULSA EL BOTÓN DE EDITAR, PARA DESPUÉS ENVIARLO AL MODAL.
$(document).ready(function(){
    $('#datatable_schedules').on('click', '.edit-btn', function () {
        const id = $(this).data('id');
        const classId = $(this).data('classid');
        const quarterId = $(this).data('quarterid');
        const roomId = $(this).data('roomid');
        const day = $(this).data('day');
        const startime = $(this).data('startime');
        const endtime = $(this).data('endtime');

        $('#scheduleUpdateModal').attr('data-id', id);
        $('#scheduleUpdateModal').attr('data-classid', classId);
        $('#scheduleUpdateModal').attr('data-quarterid', quarterId);
        $('#scheduleUpdateModal').attr('data-roomid', roomId);
        $('#scheduleUpdateModal').attr('data-day', day);
        $('#scheduleUpdateModal').attr('data-startime', startime);
        $('#scheduleUpdateModal').attr('data-endtime', endtime);

        $('#scheduleUpdateModal').modal('show');
    });

    $('#datatable_schedules').on('click', '.delete-btn', function () {
        const id = $(this).data('id');
        $('#deleteScheduleId').val(id);
        $('#deleteScheduleModal').modal('show');
    });
});
