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
        {className: "text-center",targets:[0,1,2,3,4]},
        {orderable: false,targets:[3,4]},
        {searchable:false,targets:[3,4]},
        {width:"",targets:[]}
    ],
    pageLength:10,
    language:{
        url:`${cleanBasePath}assets/js/datatables-2-1-3/spanishMX.json`
    }
};
const initDataTable=async(showMode)=>{
    if(dataTableInitiated){
        dataTable.destroy();
        destroy=true;
    }

    await listClasses(showMode);

    dataTable=$('#datatable_classes').DataTable(dataTableOptions);

    dataTableInitiated=true;
};



const listClasses=async(filterStatus)=>{
    try{
        const response=await fetch(`${cleanBasePath}data/classes`);
        const data=await response.json();

        let content= ``;
        data.classes
            .filter(cl => cl.status === filterStatus)
            .forEach((cl,index) => {
            content+=`
            <tr>
                <td>${cl.name}</td>
                <td>${cl.grade.number}</td>
                <td>${cl.program.name}</td>
                <td>
                    <i class="${cl.status ? 'bi bi-check-circle' : 'bi bi-x-circle'}" 
                       style="color: ${cl.status ? 'green' : 'red'};">
                    </i>
                </td>
                <td>
                      <button class="btn ${!cl.status ? 'btn-outline-secondary' : 'btn-primary'} btn-sm edit-btn" 
                        data-id="${cl.id}"
                        data-name="${cl.name}"
                        data-programid="${cl.program.id}" }
                        data-gradeid="${cl.grade.id}"
                        ${cl.status ? '' : 'disabled'} //CUIDADO: NO USAR MAYUSCULAS EN DATA
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
    await initDataTable(true);
});

$(document).ready(function() {
    $('#datatable_classes').on('click', '.edit-btn', function() {
        const id = $(this).data('id');
        const name = $(this).data('name');
        const programId = $(this).data('programid');
        const gradeId = $(this).data('gradeid');

        $('#classeUpdateModal').attr('data-id', id);
        $('#classeUpdateModal').attr('data-name', name);
        $('#classeUpdateModal').attr('data-programid', programId);
        $('#classeUpdateModal').attr('data-gradeid', gradeId);

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
document.getElementById('showBtn').addEventListener('click', async () => {
    const button = document.getElementById('showBtn');
    const showActive = button.getAttribute('data-showActive') === 'false';
    button.setAttribute('data-showActive', showActive);
    button.textContent = !showActive ? 'Ver clases activas' : 'Ver clases inactivas';
    await initDataTable(showActive);
});