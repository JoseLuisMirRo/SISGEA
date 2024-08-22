const basePath = `${window.location.origin}${window.location.pathname}`;
const lastSlashIndex = basePath.lastIndexOf('/');
const cleanBasePath = basePath.substring(0, lastSlashIndex + 1);
const fetchRooms = async () => {
    try{
        const response = await fetch(`${cleanBasePath}data/rooms`);
        const rooms = await response.json();

        const activeRooms = rooms.filter(room => room.status === true);

        return activeRooms.map(room => ({
            id: room.id,
            title: `${room.roomType.abbreviation}${room.number}${room.building.abbreviation}`,
            //eventColor: getEventColor(room.roomType.abbreviation)
        }));
    }catch (error){
        console.log('Error: ', error);
    }
}
function getEventColor(abbreviation){
    switch (abbreviation){
        case 'A':
            return '#FFD700';
        case 'CC':
            return '#FF4500';
        default:
            return '#9b9b9b';
    }
}
const fetchReserves = async () => {
    try{
        const response = await fetch (`${cleanBasePath}data/reserves`);
        const reserves = await response.json();

        return reserves
            .filter(reserve => reserve.status === 'Active')
            .map(reserve => ({
            id: `R${reserve.id}`,
            resourceId: reserve.room.id,
            title: `Reserva: ${reserve.description} - Autor: ${reserve.user.firstName} ${reserve.user.lastNameP} ${reserve.user.lastNameM}`,
            start: `${(reserve.date)}T${hourTo24(reserve.startTime)}`,
            end: `${(reserve.date)}T${hourTo24(reserve.endTime)}`,
            color: '#0078ff'
        }));
    }catch (error){
        console.log('Error: ', error);
    }
}
const fetchSchedules = async () => {
    try{
        const response = await fetch(`${cleanBasePath}data/schedules`);
        const schedules = await response.json();

        //NonBussinesDays
        const nonBusinessDaysResponse = await fetchNonBusinessDays();
        const nonBusinessDays = nonBusinessDaysResponse.map(nbd => nbd.start);

        const formattedEvents = [];

        schedules.forEach(schedule => {
            const startDate = (schedule.quarter.startDate);
            const endDate = (schedule.quarter.endDate);
            const dayOfWeek = schedule.day.id;

            const classDates = generateDates(startDate, endDate, dayOfWeek);

            const startTime24 = hourTo24(schedule.startTime);
            const endTime24 = hourTo24(schedule.endTime);

            classDates.forEach(date => {
                const formattedDate = date.toISOString().split('T')[0]; //Obtenemos la fecha generada en formato yyyy-mm-dd

                if(!nonBusinessDays.includes(formattedDate)) { //Si la fecha generada no es un día feriado
                    formattedEvents.push({
                        id: `S${schedule.id}`,
                        resourceId: schedule.room.id,
                        title: `Clase: ${schedule.classe.name} - Grupo: ${schedule.group.name} - ${schedule.classe.program.name}`,
                        start: `${formattedDate}T${startTime24}`,
                        end: `${formattedDate}T${endTime24}`,
                        color: '#d30505'
                    });
                }
            });
        });
        return formattedEvents;

    }catch (error){
        console.log('Error: ', error);
    }

}
const fetchNonBusinessDays = async () => {
    try{
        const response = await fetch(`${cleanBasePath}data/nbd`);
        const nonBusinessDays = await response.json();

        const rooms = await fetchRooms();
        const allResourceIds = rooms.map(room => room.id);

        return nonBusinessDays.map(nbd => ({
            id: `NBD${nbd.id}`,
            title: `Feriado: ${nbd.name} NO SE PUEDE RESERVAR EN ESTA FECHA`,
            start: (nbd.date),
            color: '#c10000',
            resourceIds: allResourceIds,
            allDay: true
        }));
    }catch (error){
        console.log('Error: ', error);
    }
}
const  generateDates = (startDate, endDate, dayOfWeek) =>{
    let dates = [];
    let currentDate = new Date(startDate);
    const end = new Date(endDate);

    //Avanzar hasta el primer día de la semana que coincide con el día de la semana deseado
    while (currentDate.getDay() !== dayOfWeek-1) {
        currentDate.setDate(currentDate.getDate()+1);
    }

    //Generar todas las fechas que coincidan con el día de la semana en el rango
    while (currentDate <= end) {
        dates.push(new Date(currentDate));
        currentDate.setDate(currentDate.getDate() + 7);

    }
    return dates;
}

const hourTo24 = (hour12) => {
    const parts = hour12.split(' '); //DIVIDIMOS POR ESPACIOS PARA SEPARAR AM Y PM
    const time = parts[0] //OBTENEMOS LA PARTE SOLO CON LA HORA
    const period = parts[1] //OBTENEMOS LA PARTE SOLO CON AM Y PM

    let [hour, minute, second] = time.split(':'); //DIVIDIMOS HORAS, MINUTOS Y SEGUNDOS
    hour = parseInt(hour,10);

    if(period === 'p. m.' && hour !== 12){
        hour +=12;
    }
    else if (period === 'a. m.' && hour === 12){
        hour = 0;
    }
    return `${hour.toString().padStart(2, '0')}:${minute}:${second}`;
}


