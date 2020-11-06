using Toybox.Time;
using Toybox.UserProfile;
using Toybox.WatchUi;

class WinterpokalView extends WatchUi.SimpleDataField {

	protected var minutesPerPoint = 15;
	protected var isAlternativeSport = false;

    // Set the label of the data field and initialize basic options
    function initialize() {
        SimpleDataField.initialize();
              
        label = WatchUi.loadResource(Rez.Strings.FieldTitle);
 	 	initMinutesPerPoint();
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
		if (info.timerTime != null && info.timerTime > 0) {
			if (self.isAlternativeSport) {
				return 2;
			} else {
				var minutes = info.timerTime / 60000;
				var wpPoints = minutes / self.minutesPerPoint;
				
				return wpPoints;
			}
		}
        return "--";        
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