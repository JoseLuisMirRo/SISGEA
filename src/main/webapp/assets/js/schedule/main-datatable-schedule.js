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
            content+=`
            <tr>
                <td>${sch.classe.name}</td>
                <td>${sch.room.roomType.abbreviation}${sch.room.number}${sch.room.building.abbreviation}</td>
                <td>${sch.day}</td>
                <td>${sch.startTime}</td>
                <td>${sch.endTime}</td>
                <td>
                    <button class="btn btn-primary btn-sm edit-btn" 
                    data-id="${sch.id}"
                    data-schclassid="${sch.classe.id}"
                    data-buildingid="${sch.quarter.id}" //CUIDADO: NO USAR MAYUSCULAS EN DATA
                    data-roomid="${sch.room.id}"
                    data.day="${sch.day}"
                    data.startime="${sch.startTime}"
                    data.endtime="${sch.endTime}"
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

