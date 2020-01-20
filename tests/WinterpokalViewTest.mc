using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Application;
using Toybox.Test;

class WinterpokalViewTest {

	(:test)
	function compute_CurrentDateBeforeWpTime_ExpectsSummertime(logger) {
		// how to mock the time.today() function?
		return true;
	}
	
	(:test)
	function compute_CurrentDateAfterWpTime_ExpectsSummertime(logger) {
		// how to mock the time.today() function?
		return true;
	}
	
	(:test)
	function compute_ElapsedTimeIsNullOrZero_ExpectsDash(logger) {
		var subject = new WinterpokalView();
		subject.initialize();
			
		var testActivity = new Activity.Info();
		testActivity.elapsedTime = 0;
		var result = subject.compute(testActivity);
		Test.assertEqual(result, "-");
		return true;
	}
	
	(:test)
	function compute_ElapsedTimeIs15Minutes_Expects1Point(logger) {
		var subject = new WinterpokalView();
		subject.initialize();
		subject.setMinutesPerPoint(15);
		subject.setIsAlternativeSport(false);
	
		var testActivity = new Activity.Info();
		testActivity.elapsedTime = 15 * 60 * 1000;
		var result = subject.compute(testActivity);
		Test.assertEqual(result, 1);
		return true;
	}
	
	(:test)
	function compute_ElapsedTimeIs120Minutes_Expects8Points(logger) {
		var subject = new WinterpokalView();
		subject.initialize();
		subject.setMinutesPerPoint(15);
		subject.setIsAlternativeSport(false);
		
		var testActivity = new Activity.Info();
		testActivity.elapsedTime = 120 * 60 * 1000;
		var result = subject.compute(testActivity);
		Test.assertEqual(result, 8);
		return true;
	}
	
	(:test)
	function compute_ElapsedTimeIs14Minutes59Seconds_Expects0Points(logger) {
		var subject = new WinterpokalView();
		subject.initialize();
		subject.setMinutesPerPoint(15);
		subject.setIsAlternativeSport(false);
		
		var testActivity = new Activity.Info();
		testActivity.elapsedTime = (15 * 60 * 1000) - 1;
		var result = subject.compute(testActivity);
		Test.assertEqual(result, 0);
		return true;
	}
	
	(:test)
	function compute_AlternativeSports_Expects2Points(logger) {
		var subject = new WinterpokalView();
		subject.initialize();
		subject.setIsAlternativeSport(true);
			
		var testActivity = new Activity.Info();
		testActivity.elapsedTime = 5 * 60 * 1000;
		var result = subject.compute(testActivity);
		Test.assertEqual(result, 2);

		return true;	
	}
	
}
