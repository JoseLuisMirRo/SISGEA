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
        {className: "text-center",targets:[0,1,2]},
        {orderable: false,targets:[2]},
        {searchable:false,targets:[2]},
        {width:"",targets:[]}
    ],
    pageLength:10,
    language:{
        url:`${cleanBasePath}assets/js/datatables-2-1-3/spanishMX.json`
    }
};
const initDataTable=async()=>{
    const loadingAnimation = document.getElementById('loading-animation');
    const nbdTable = document.getElementById('nbd-table');
    loadingAnimation.style.display = 'block';
    nbdTable.style.display = 'none';

    if(dataTableInitiated){
        dataTable.destroy();
        destroy=true;
    }

    await listNbd();

    dataTable=$('#datatable_nbd').DataTable(dataTableOptions);

    dataTableInitiated=true;
    loadingAnimation.style.display = 'none';
    nbdTable.style.display = 'block';
};



const listNbd=async()=>{
    try{
        const response=await fetch(`${cleanBasePath}data/nbd`);
        const nbd=await response.json();

        let content= ``;
        nbd.forEach((nbd,index) => {
            content+=`
            <tr>
                <td>${nbd.name}</td>
                <td>${nbd.date}</td>
                <td>
                    <button class="btn btn-primary btn-sm edit-btn" 
                    data-id="${nbd.id}"
                    data-date="${nbd.date}"
                    data-name="${nbd.name}" //CUIDADO: NO USAR MAYUSCULAS EN DATA
                    ><i class="bi bi-pencil-square"></i></button>
                    
                    <button class="btn btn-danger btn-sm delete-btn"
                    data-id="${nbd.id}"
                    ><i class="bi bi-trash3-fill"></i></button>
                </td>
            </tr>`;
        });
        tableBody_nbd.innerHTML=content;

    }catch(ex){
        alert(ex);
    }
};

window.addEventListener('load',async()=>{
    await initDataTable();
});

//UTILIZANDO JQUERY OBTENEMOS DATOS DE HORARIO CUANDO SE PULSA EL BOTÓN DE EDITAR, PARA DESPUÉS ENVIARLO AL MODAL.
$(document).ready(function() {
    $('#datatable_nbd').on('click', '.edit-btn', function () {
        const id = $(this).data('id');
        const date = $(this).data('date');
        const name = $(this).data('name');

        $('#nbdUpdateModal').attr('data-id', id);
        $('#nbdUpdateModal').attr('data-date', date);
        $('#nbdUpdateModal').attr('data-name', name);

        $('#nbdUpdateModal').modal('show');
    });
    $('#datatable_nbd').on('click', '.delete-btn', function () {
        const id = $(this).data('id');
        $('#deleteNbdId').val(id);
        $('#deleteNbdModal').modal('show');
    });
});

