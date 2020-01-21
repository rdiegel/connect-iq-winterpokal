using Toybox.Time;
using Toybox.UserProfile;
using Toybox.WatchUi;

class WinterpokalView extends WatchUi.SimpleDataField {

	protected var minutesPerPoint = 15;
	protected var isAlternativeSport = false;
	protected var itsWinterpokalTime = true;

    // Set the label of the data field and initialize basic options
    function initialize() {
        SimpleDataField.initialize();
      
        label = WatchUi.loadResource(Rez.Strings.FieldTitle);
 	 	initMinutesPerPoint();
        checkWinterpokalTime();
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
		if (self.itsWinterpokalTime)
		{
			if (info.elapsedTime > 0) {
				if (self.isAlternativeSport) {
					return "2 pt";
				} else {
					var minutes = info.elapsedTime / 60000;
					var wpPoints = minutes / self.minutesPerPoint;
					
					return wpPoints + " pt";
				}
			}
	        return "-- pt";
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
 	 		self.itsWinterpokalTime = true;
 	 	} else {
 	 		self.itsWinterpokalTime = false;
 	 	}
 	 }
 	 
 	 // Load the minutes that are necessary for 1 point depending on sports
 	 function initMinutesPerPoint() {
 	 	var sport = UserProfile.getCurrentSport();
 	 	
 	 	switch (sport) {
 	 		case UserProfile.HR_ZONE_SPORT_RUNNING: 
 	 			// Running: 20 mins / point
 	 			setMinutesPerPoint(20);
 	 			setIsAlternativeSport(false);
 	 			break;
 	 		case UserProfile.HR_ZONE_SPORT_BIKING:
 	 			// Cycling: 15 mins / point
 	 			setMinutesPerPoint(15);
 	 			setIsAlternativeSport(false);
 	 			break;
 	 		default:
 	 			// All other sports are woth 2 points 
 	 			setIsAlternativeSport(true);
 	 	}
  	 }
  	 
  	 function setIsAlternativeSport(_isAlternativeSport) {
  	 	self.isAlternativeSport = _isAlternativeSport;
  	 }
  	 
  	 function setMinutesPerPoint(_minutesPerPoint) {
  	 	self.minutesPerPoint = _minutesPerPoint;
  	 }
}