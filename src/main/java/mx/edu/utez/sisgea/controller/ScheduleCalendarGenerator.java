package mx.edu.utez.sisgea.controller;

import mx.edu.utez.sisgea.dao.QuarterDao;
import mx.edu.utez.sisgea.dao.ScheduleDao;
import mx.edu.utez.sisgea.model.QuarterBean;
import mx.edu.utez.sisgea.model.ScheduleBean;
import mx.edu.utez.sisgea.model.ScheduleCalendarBean;

import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import java.util.ArrayList;

public class ScheduleCalendarGenerator {
    public List<ScheduleCalendarBean> generateCalendar(List<ScheduleBean> schList) {
        ScheduleDao scheduleDao = new ScheduleDao();
        QuarterDao quarterDao = new QuarterDao();
        List<ScheduleCalendarBean> calendar = new ArrayList<>();

        for (ScheduleBean schedule : schList) {
            QuarterBean quarter = quarterDao.getQuarter(schedule.getQuarter().getId());
            LocalDate startDate = quarter.getStartDate().toLocalDate();
            LocalDate endDate = quarter.getEndDate().toLocalDate();
            LocalDate currentDate = startDate;

            while (!currentDate.isAfter(endDate)) {
                if (currentDate.getDayOfWeek().getValue() == schedule.getDay().ordinal() + 1) {
                    ScheduleCalendarBean scheduleCalendar = new ScheduleCalendarBean();
                    scheduleCalendar.setClasse(schedule.getClasse());
                    scheduleCalendar.setQuarter(schedule.getQuarter());
                    scheduleCalendar.setRoom(schedule.getRoom());
                    scheduleCalendar.setDate(currentDate);
                    scheduleCalendar.setStartTime(schedule.getStartTime());
                    scheduleCalendar.setEndTime(schedule.getEndTime());
                    calendar.add(scheduleCalendar);
                }
                currentDate = currentDate.plusDays(1);
            }
        }
        calendar.sort(Comparator.comparing(ScheduleCalendarBean::getDate));
        return calendar;
    }

    public static void main(String[] args) {
        ScheduleCalendarGenerator generator = new ScheduleCalendarGenerator();
        ScheduleDao schDao = new ScheduleDao();
        List<ScheduleBean> schList = schDao.getAllSchedules();

        List<ScheduleCalendarBean> calendarList = generator.generateCalendar(schList);

        for(ScheduleCalendarBean scb : calendarList){
            System.out.println(scb.getDate());
            System.out.println(scb.getStartTime());
            System.out.println(scb.getEndTime());
            System.out.println(scb.getClasse().getName());
        }
    }
}
