using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Application;

class WinterpokalView extends WatchUi.SimpleDataField {

	protected var itsWinterpokalTime = false;
	protected var minutesPerPoint = 15;

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
      
        label = WatchUi.loadResource(Rez.Strings.FieldTitle);
 	 	self.minutesPerPoint = getMinutesPerPoint();
        self.itsWinterpokalTime = checkWinterpokalTime();
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
		if (self.itsWinterpokalTime)
		{
			if (info.elapsedTime > 0) {
				var minutes = info.elapsedTime / 60000;
				var wpPoints = minutes / self.minutesPerPoint;
				
				return wpPoints;
			}
	        return "-";
        }  else {
        	return WatchUi.loadResource(Rez.Strings.NotWpTime);
        }
        
 	 }
 	 
 	 // Ensure that the current date is part of the Winterpokal applicable timespan
 	 function checkWinterpokalTime() {

 	 	var today = new Time.Moment(Time.today().value());
		var startDate = new Time.Moment(1572217200); // 28.10.2019 00:00:00
		var endDate = new Time.Moment(1585519199); // 29.03.2020 23:59:59

		if (today.greaterThan(startDate) && today.lessThan(endDate)) {
 	 		return true;
 	 	} else {
 	 		return false;
 	 	}
 	 }
 	 
 	 // Load the minutes that are necessary for 1 point
 	 function getMinutesPerPoint() {
 	 	// Check activity type
 	 	return 15;
 	 }

}