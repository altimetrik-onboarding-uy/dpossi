global class scheduledBatchable implements Schedulable {
   global void execute(SchedulableContext sc) {
      sendEmail send = new sendEmail();
      database.executebatch(send);
   }
}