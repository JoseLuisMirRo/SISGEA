const fetchRooms = async () => {
    try{
        const response = await fetch('http://localhost:8080/SISGEA_war_exploded/data/rooms');
        const rooms = await response.json();

        return rooms.map(room => ({
            id: room.id,
            title: `${room.roomType.abbreviation}${room.number}${room.building.abbreviation}`,
            eventColor: getEventColor(room.roomType.abbreviation)
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
        const response = await fetch ('http://localhost:8080/SISGEA_war_exploded/data/reserves');
        const reserves = await response.json();

        return reserves.map(reserve => ({
            id: reserve.id,
            resourceId: reserve.room.id,
            title: `${reserve.description} - ${reserve.user.firstName} ${reserve.user.lastNameP} ${reserve.user.lastNameM}`,
            start: `${manageDate(reserve.date)}T${hourTo24(reserve.startTime)}`,
            end: `${manageDate(reserve.date)}T${hourTo24(reserve.endTime)}`,
        }));
    }catch (error){
        console.log('Error: ', error);
    }
}
const fetchSchedules = async () => {
    try{
        const response = await fetch('http://localhost:8080/SISGEA_war_exploded/data/schedules');
        const schedules = await response.json();

        return schedules.map(schedule => ({
            id: schedule.id,
            resourceId: schedule.room.id,
            title: schedule.classe.name,
            start: `${manageDate(schedule.date)}T${hourTo24(schedule.startTime)}`,
            end: `${manageDate(schedule.date)}T${hourTo24(schedule.endTime)}`,
        }));
    }catch (error){
        console.log('Error: ', error);
    }

}
const hourTo24 = (hour12) => {
    const parts = hour12.split(' '); //DIVIDIMOS POR ESPACIOS PARA SEPARAR AM Y PM
    const time = parts[0] //OBTENEMOS LA PARTE SOLO CON LA HORA
    const period = parts[1] //OBTENEMOS LA PARTE SOLO CON AM Y PM

    let [hour, minute, second] = time.split(':'); //DIVIDIMOS HORAS, MINUTOS Y SEGUNDOS
    hour = parseInt(hour, 10);
    console.log(period);

    if (period === 'p. m.' && hour!==12) {
        console.log('PM');
        hour += 12;
    } else if (period === 'a. m.' && hour === 12) {
        console.log('AM');
        hour = 0;
    }
    console.log(hour);
    return `${hour.toString().padStart(2, '0')}:${minute}:${second}`;
}

const manageDate = (dateD) => {
    const months = {
        'ene.': 0, 'feb.': 1, 'mar.': 2, 'abr.': 3,
        'may.': 4, 'jun.': 5, 'jul.': 6, 'ago.': 7,
        'sep.': 8, 'oct.': 9, 'nov.': 10, 'dic.': 11
    };

    const parts = dateD.split(' ');
    const month = months[parts[0]];
    const day = parseInt(parts[1].replace(',', ''), 10);
    const year = parseInt(parts[2], 10);
    const date = new Date(year, month, day);

    const yearStr = date.getFullYear().toString();
    const monthStr = (date.getMonth() + 1).toString().padStart(2, '0');
    const dayStr = date.getDate().toString().padStart(2, '0');

    return `${yearStr}-${monthStr}-${dayStr}`;
}