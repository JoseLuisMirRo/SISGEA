let dataTable;
let dataTableInitiated=false;

const dataTableOptions={
    //scrollX: "2000px"
    lengthMenu:[5,10,25],
    scrollX: true,
    columnDefs: [
        {className: "text-center",targets:[0,1,2,3,4]},
        {orderable: false,targets:[3,4]},
        {serchable:false,targets:[3,4]},
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



const listRooms=async()=>{
    try{
        const response=await fetch('http://localhost:8080/SISGEA_war_exploded/data/rooms');
        const rooms=await response.json();

        let content= ``;
        rooms.forEach((room,index) => {
            content+=`
            <tr>
                <td>${room.id}</td>
                <td>${room.roomtype_id}</td>
                <td>${room.building_id}</td>
                <td>${room.number}</td>
                <td>${room.name}</td>
                <td>
                    <i class="${room.status ? 'bi bi-check-circle' : 'bi bi-x-circle'}" 
                       style="color: ${room.status ? 'green' : 'red'};">
                    </i>
                    </td>
                <td>
                    <button class="btn btn-primary btn-sm edit-btn" data-id="${room.id}" 
                    data-id="${room.id}"
                    data-email="${room.roomtype_id}"
                    data-firstname="${room.building_id}" //CUIDADO: NO USAR MAYUSCULAS EN DATA
                    data-lastnamep="${room.number}"
                    data-lastnamem="${room.name}"
                    data-password="${room.status}"
                    ><i class="bi bi-pencil-square"></i></button>
                    
                    <button class="${room.status ? 'btn btn-danger btn-sm delete-btn' : 'btn btn-success btn-sm enable-btn'}"
                    data-id="${user.id}"
                    data-status="${user.status}"
                    ><i class="${user.status ? 'bi bi-trash3-fill' : 'bi bi-check-square-fill'}"></i></button>
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
});

//UTILIZANDO JQUERY OBTENEMOS EL DATOS DEL USUARIO CUANDO SE PULSA EL BOTÓN DE EDITAR, PARA DESPUES ENVIARLO AL MODAL. (se podría obtener solo id y lo demás con un select).
$(document).ready(function() {
    $('#datatable_users').on('click', '.edit-btn', function () {
        const id = $(this).data('id');
        const firstName = $(this).data('firstname');
        const lastNameP = $(this).data('lastnamep');
        const lastNameM = $(this).data('lastnamem');
        const email = $(this).data('email');
        const password = $(this).data('password');
        let roleIds = $(this).data('roles-ids');

        if(typeof roleIds === 'string'){ //Si roleIds es una cadena, la dividimos por coma y la metemos en un arreglo
            roleIds = roleIds.split(',');
        }
        else {
            roleIds = [roleIds]; //Si no es cadena, directamente la convertimos en un arreglo
        }

        $('#updateUserId').val(id);
        $('#updateName').val(firstName);
        $('#updateLastNameP').val(lastNameP);
        $('#updateLastNameM').val(lastNameM);
        $('#updateEmail').val(email);
        $('#updatePassword').val(password);

        $('[name="updateRoles[]"]').prop("checked",false);
        roleIds.forEach(roleId => {
            $(`[name="updateRoles[]"][value="${roleId}"]`).prop('checked', true);
        });

        $('#updateUserModal').modal('show');
    });

    $('#datatable_users').on('click', '.delete-btn', function () {
        const id = $(this).data('id');
        const status = $(this).data('status');
        $('#deleteUserId').val(id);
        $('#deleteUserModal').modal('show');
    });

    $('#datatable_users').on('click', '.enable-btn', function () {
        const id = $(this).data('id');
        const status = $(this).data('status');
        $('#revertDeleteUserId').val(id);
        $('#revertDeleteUserModal').modal('show');
    });


});
