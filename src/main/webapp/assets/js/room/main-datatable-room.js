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
        {className: "text-center",targets:[0,1,2,3,4,5]},
        {orderable: false,targets:[4,5]},
        {searchable:false,targets:[4,5]},
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

    await listRooms();

    dataTable=$('#datatable_rooms').DataTable(dataTableOptions);

    dataTableInitiated=true;
};



const listRooms=async(showActive = true)=>{
    try{
        const response=await fetch(`${cleanBasePath}data/rooms`);
        const rooms=await response.json();

        let content= ``;
        rooms.forEach((room,index) => {
            if(showActive && !room.status){
                return;
            }
            if(!showActive && room.status){
                return;
            }
            content+=`
            <tr>
                <td>${room.roomType.abbreviation}${room.number}${room.building.abbreviation}</td>
                <td>${room.roomType.name}</td>
                <td>${room.number}</td>
                <td>${room.building.name}</td>
                <td>
                    <i class="${room.status ? 'bi bi-check-circle' : 'bi bi-x-circle'}" 
                       style="color: ${room.status ? 'green' : 'red'};">
                    </i>
                    </td>
                <td>
                    <button class="btn btn-primary btn-sm edit-btn" 
                    data-id="${room.id}"
                    data-roomtypeid="${room.roomType.id}"
                    data-buildingid="${room.building.id}" //CUIDADO: NO USAR MAYUSCULAS EN DATA
                    data-number="${room.number}"
                    ><i class="bi bi-pencil-square"></i></button>
                    
                    <button class="${room.status ? 'btn btn-danger btn-sm delete-btn' : 'btn btn-success btn-sm enable-btn'}"
                    data-id="${room.id}"
                    data-status="${room.status}"
                    ><i class="${room.status ? 'bi bi-trash3-fill' : 'bi bi-check-square-fill'}"></i></button>
                </td>
            </tr>`;
        });
        tableBody_rooms.innerHTML=content;

    }catch(ex){
        alert(ex);
    }
};

window.addEventListener('load',async()=>{
    await initDataTable();
    await listRooms(true);
    document.getElementById('historyBtn').setAttribute('data-showActive',true);
});

//UTILIZANDO JQUERY OBTENEMOS DATOS DEL USUARIO CUANDO SE PULSA EL BOTÓN DE EDITAR, PARA DESPUES ENVIARLO AL MODAL. (se podría obtener solo id y lo demás con un select).
$(document).ready(function() {
    $('#datatable_rooms').on('click', '.edit-btn', function () {
        const id = $(this).data('id');
        const roomTypeId = $(this).data('roomtypeid');
        const buildingId = $(this).data('buildingid');
        const number = $(this).data('number');

        $('#updateRoomModal').attr('data-id', id);
        $('#updateRoomModal').attr('data-roomtypeid', roomTypeId);
        $('#updateRoomModal').attr('data-buildingid', buildingId);
        $('#updateRoomModal').attr('data-number', number);

        $('#updateRoomModal').modal('show');
    });

    $('#datatable_rooms').on('click', '.delete-btn', function () {
        const id = $(this).data('id');
        const status = $(this).data('status');
        $('#deleteRoomId').val(id);
        $('#deleteRoomModal').modal('show');
    });

    $('#datatable_rooms').on('click', '.enable-btn', function () {
        const id = $(this).data('id');
        const status = $(this).data('status');
        $('#revertDeleteRoomId').val(id);
        $('#revertDeleteRoomModal').modal('show');
    });


});
document.getElementById('historyBtn').addEventListener('click',async()=>{
    const button = document.getElementById('historyBtn');
    const showActive = button.getAttribute('data-showActive')==='true';

    await listRooms(!showActive);
    button.setAttribute('data-showActive',!showActive);
    button.textContent = showActive ? 'Ver espacios activos' : 'Ver espacios inactivos';
});
