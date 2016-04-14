describe('Reports', function() {
    var allTripsCssSelector = 'ion-view[view-title="My Trips"] ion-item.item-avatar';
    var reportTabsCssSelector = 'ion-tabs[nav-view="active"] > div.tab-nav > a.tab-item';
    var buttonTitles = ['Text Reporting', 'Pictures', 'Action Points'];

    it('should be able to login and select the My Trips tab', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(0).click();
    });

    it('should be able click the first trip and click the report button', function() {    
        var trips = element.all(by.css(allTripsCssSelector));
        trips.first().click();

        waitForElement('button.button-calm');
        element(by.buttonText('Report')).click();
        waitForElement('button#report_text');
    });

    it('should be able see ' + buttonTitles.length + ' buttons, click on each button and click on the back button', function() {        
        _.each(buttonTitles, function(buttonTitle, tabIndex){
            element(by.buttonText(buttonTitle)).click();
            waitForElement('button.back-button:not(.hide)');
            element.all(by.css('button.back-button:not(.hide)')).get(0).click();
            waitForElement('button#report_text');
        });
    });
});