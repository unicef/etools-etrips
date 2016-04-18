describe('Reports - Pictures', function() {
    var allTripsCssSelector = 'ion-view[view-title="My Trips"] ion-item.item-avatar';
    var reportTabsCssSelector = 'ion-tabs[nav-view="active"] > div.tab-nav > a.tab-item';

    it('should be able to login and select the My Trips tab', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(0).click();
    });

    it('should be able select the first Trip, click on Report and click on the Picture tab', function() {        
        var trips = element.all(by.css(allTripsCssSelector));
        trips.first().click();
        waitForElement('button.button-calm');

        waitForElement('button.button-calm');
        element(by.buttonText('Report')).click();
        
        waitForElement('button#report_text');
        element(by.buttonText('Pictures')).click();

        waitForElement('a.button-positive');
        element(by.linkText('Add Picture')).click();

        waitForElement('textarea');
        element(by.buttonText('Upload Existing Photo')).isPresent().should.eventually.true;
        element(by.buttonText('Take Picture')).isPresent().should.eventually.true;        
    });

    it('should be able to logout', function() {
        element.all(by.css('button.back-button:not(.hide)')).get(1).click();
        waitForElement('button.back-button:not(.hide)');

        element.all(by.css('button.back-button:not(.hide)')).get(0).click();
        waitForElement('button.back-button:not(.hide)');

        element.all(by.css('button.back-button:not(.hide)')).get(1).click();
        waitForElement('button.back-button:not(.hide)');
        
        element.all(by.css('button.back-button:not(.hide)')).get(0).click();
        waitForElement('button[menu-toggle="left"]:not(.hide)');
        auth.logout();
    });
});