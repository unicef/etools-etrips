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

        element(by.buttonText('Report')).click();
        waitForElement('a.tab-item-active > i.icon.ion-document-text');

        element(by.linkText('Picture')).click();
        element(by.buttonText('Upload Existing Photo')).isPresent().should.eventually.true;
        element(by.buttonText('Take Picture')).isPresent().should.eventually.true;        
    });

    it('should be able to logout', function() {
        auth.logout();
    });

    afterEach(function() {
        browser.takeScreenshot().then(function(png) {
            var stream = fs.createWriteStream('./' + path.basename(__filename, '.js') + '_screenshot.png');
            stream.write(new Buffer(png, 'base64'));
            stream.end();
        });        
    });
});