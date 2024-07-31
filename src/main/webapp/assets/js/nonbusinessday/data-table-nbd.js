let dataTable;
let dataTableInitiated=false;

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
        url:'https://cdn.datatables.net/plug-ins/2.0.8/i18n/es-ES.json'
    }
};
const initDataTable=async()=>{
    if(dataTableInitiated){
        dataTable.destroy();
        destroy=true;
    }

    await listNbd();

    dataTable=$('#datatable_nbd').DataTable(dataTableOptions);

    dataTableInitiated=true;
};



const listNbd=async()=>{
    try{
        const response=await fetch('http://localhost:8080/SISGEA_war_exploded/data/nbd');
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

