let dataTable;
let dataTableInitiated=false;

const dataTableOptions={
    //scrollX: "2000px"
    lengthMenu:[5,10,25],
    scrollX: true,
    columnDefs: [
        {className: "text-center",targets:[0,1,2,3]},
        {orderable: false,targets:[3]},
        {searchable:false,targets:[3]},
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

    await listClasses();

    dataTable=$('#datatable_classes').DataTable(dataTableOptions);

    dataTableInitiated=true;
};



const listClasses=async()=>{
    try{
        const response=await fetch('http://localhost:8080/SISGEA_war_exploded/data/classes');
        const data=await response.json();

        let content= ``;
        data.classes.forEach((cl,index) => {
            content+=`
            <tr>
                <td>${cl.name}</td>
                <td>${cl.program.name}</td>
                <td>
                    <i class="${cl.status ? 'bi bi-check-circle' : 'bi bi-x-circle'}" 
                       style="color: ${cl.status ? 'green' : 'red'};">
                    </i>
                </td>
                <td>
                    <button class="btn btn-primary btn-sm edit-btn" 
                    data-id="${cl.id}"
                    data-name="${cl.name}"
                    data-programid="${cl.program.id}" //CUIDADO: NO USAR MAYUSCULAS EN DATA
                    ><i class="bi bi-pencil-square"></i></button>
                    
                     <button class="${cl.status ? 'btn btn-danger btn-sm delete-btn' : 'btn btn-success btn-sm enable-btn'}"
                    data-id="${cl.id}"
                    data-status="${cl.status}"
                    ><i class="${cl.status ? 'bi bi-trash3-fill' : 'bi bi-check-square-fill'}"></i></button>
                </td>
            </tr>`;
        });
        tableBody_classes.innerHTML=content;

    }catch(ex){
        alert(ex);
    }
};

window.addEventListener('load',async()=>{
    await initDataTable();
});

$(document).ready(function() {
    $('#datatable_classes').on('click', '.edit-btn', function() {
        const id = $(this).data('id');
        const name = $(this).data('name');
        const programId = $(this).data('programid');

        $('#classeUpdateModal').attr('data-id', id);
        $('#classeUpdateModal').attr('data-name', name);
        $('#classeUpdateModal').attr('data-programid', programId);

        $('#classeUpdateModal').modal('show');
    });

    $('#datatable_classes').on('click', '.delete-btn', function() {
        const id = $(this).data('id');
        $('#deleteClassId').val(id);
        $('#deleteClasseModal').modal('show');
    });

    $('#datatable_classes').on('click', '.enable-btn', function() {
        const id = $(this).data('id');
        $('#revertDeleteClassId').val(id);
        $('#revertDeleteClasseModal').modal('show');
    });

});