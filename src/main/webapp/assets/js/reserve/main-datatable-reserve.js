let dataTable;
let dataTableInitiated=false;

const dataTableOptions={
    //scrollX: "2000px"
    lengthMenu:[5,10,25],
    scrollX: true,
    columnDefs: [
        {className: "text-center",targets:[0,1,2,3,4,5,6,7]},
        {orderable: false,targets:[6,7]},
        {searchable:false,targets:[6,7]},
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

    await listReserves();

    dataTable=$('#datatable_reserves').DataTable(dataTableOptions);

    dataTableInitiated=true;
};



const listReserves=async()=>{
    try{
        const response=await fetch('http://localhost:8080/SISGEA_war_exploded/data/reserves');
        const reserves=await response.json();

        let content= ``;
        reserves.forEach((rse,index) => {
            const startTime = deleteSeconds(rse.startTime);
            const endTime = deleteSeconds(rse.endTime);
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
                                        rse.status === 'Admin_Canceled' ? 'orange' : 'black'};">
                    </i>
                </td>
                <td>
                    <button class="btn btn-primary btn-sm edit-btn" 
                    data-id="${rse.id}"
                    data-roomid="${rse.room.id}"
                    data-date="${rse.date}" //CUIDADO: NO USAR MAYUSCULAS EN DATA
                    data-description="${rse.description}"
                    data-startime="${rse.startTime}"
                    data-endtime="${rse.endTime}"
                    ><i class="bi bi-pencil-square"></i></button>
                    
                    <button class="btn btn-danger btn-sm delete-btn"
                    data-id="${rse.id}"
                    ><i class="bi bi-trash3-fill"></i></button>
                </td>
            </tr>`;
        });
        tableBody_reserves.innerHTML=content;

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
        const id = $(this).data('id');
        $('#idDelete').val(id);

        $('#deleteModal').modal('show');
    });
});