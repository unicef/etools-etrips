describe('Reports', function() {
    var allTripsCssSelector = 'ion-view[view-title="My Trips"] ion-item.item-avatar';
    var reportTabsCssSelector = 'ion-tabs[nav-view="active"] > div.tab-nav > a.tab-item';

    it('should be able to login and select the My Trips tab', function() {
        auth.login();
        element.all(by.css('a.tab-item')).get(0).click();
    });

    it('should be able select a the first Trip and view the Text Reporting tab', function() {        
        var trips = element.all(by.css(allTripsCssSelector));
        trips.first().click();

        waitForElement('button.button-calm');
        element(by.buttonText('Report')).click();

        waitForElement('a.tab-item-active > i.icon.ion-document-text');
    });

    it('should be able see four tabs and click on each tab', function() {        
        var tabs = ['Text', 'Picture', 'Actions'];
        var tabItems = element.all(by.css(reportTabsCssSelector));
        tabItems.count().should.eventually.equal(tabs.length);

        _.each(tabs, function(tabText, tabIndex){
            element(by.linkText(tabText)).click();
            element(by.css('ion-tabs[nav-view="active"] > div.tab-nav > a.tab-item.tab-item-active'));            
        });
    });

    it('should be able to logout', function() {
        auth.logout();
    });
});